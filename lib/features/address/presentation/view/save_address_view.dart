import 'dart:async';

import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/address/domain/entities/address_response_entity.dart';
import 'package:flower_app/features/address/presentation/view_model/address_state.dart';
import 'package:flower_app/features/address/presentation/view_model/address_view_model.dart';
import 'package:flower_app/features/address/presentation/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SaveAddressView extends StatefulWidget {
  const SaveAddressView({super.key});

  @override
  State<SaveAddressView> createState() => _SaveAddressViewState();
}

class _SaveAddressViewState extends State<SaveAddressView> {
  late StreamSubscription _addressSubscription;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _addNewAddressBtn(),
      appBar: AppBar(title: const Text("Save Address")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<AddressViewModel, AddressState>(
                builder: (context, state) {
                  if (state.loggedUserAddresses == null) {
                    return const SizedBox(child: Text("address is null"));
                  }
                  switch (state.loggedUserAddresses!.requestState) {
                    case RequestState.init:
                    case RequestState.loading:
                      return _addressDummyList(state);
                    case RequestState.loaded:
                      final addresses = state.loggedUserAddresses?.data;
                      return _addressList(addresses);
                    case RequestState.error:
                      return _errorInAddress(state);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _emptyAddress(){
  //
  // }

  Widget _errorInAddress(AddressState state) =>
      Center(child: Text(state.loggedUserAddresses!.errorMessage.toString()));

  Widget _addressDummyList(AddressState state) => Skeletonizer(
    enabled: state.loggedUserAddresses!.isLoading,
    child: ListView.separated(
      separatorBuilder: (context, index) => context.h(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 3,
      itemBuilder: (context, index) =>
          const AddressCard(address: AddressEntity()),
    ),
  );

  Widget _addressList(List<AddressEntity?>? addresses) => ListView.separated(
    separatorBuilder: (context, index) => context.h(16),
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 12),
    itemCount: addresses?.length ?? 1,

    itemBuilder: (context, index) =>
        AddressCard(address: addresses?[index] ?? const AddressEntity()),
  );

  Widget _addNewAddressBtn() => Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
    child: ElevatedButton(
      style: _btnStyle(),
      onPressed: () async {
        context.read<AddressViewModel>().doIntent(NavigatorToAddressView());
      },
      child: const Text("Add new address"),
    ),
  );

  _btnStyle() => ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  @override
  void dispose() {
    _addressSubscription.cancel();
    super.dispose();
  }

  void _init() {
    final viewModel = context.read<AddressViewModel>();
    context.read<AddressViewModel>().doIntent(GetLoggedUserAddress());
    _addressSubscription = context
        .read<AddressViewModel>()
        .uiEventsStream
        .listen((event) async {
          if (!mounted) return;
          if (event is DeleteAddressEvent) {
            Toast.showToast(context, "Address deleted successfully");
          }
          if (event is NavigatorToAddressView) {
            await Navigator.of(
              context,
            ).pushNamed(AppRoutes.addNewAddress, arguments: viewModel);
          }
        });
  }
}
