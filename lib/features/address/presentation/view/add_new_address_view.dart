import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/helper/app_validator.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/address/domain/entities/address_request_entity.dart';
import 'package:flower_app/features/address/presentation/view_model/address_state.dart';
import 'package:flower_app/features/address/presentation/view_model/address_view_model.dart';
import 'package:flower_app/features/address/presentation/widgets/government_address.dart';
import 'package:flower_app/features/address/presentation/widgets/map_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewAddressView extends StatefulWidget {
  const AddNewAddressView({super.key});

  @override
  State<AddNewAddressView> createState() => _AddNewAddressViewState();
}

class _AddNewAddressViewState extends State<AddNewAddressView> {
  late final TextEditingController _addressController = TextEditingController();
  late final TextEditingController _phoneController = TextEditingController();
  late final TextEditingController _recipientController =
      TextEditingController();
  late final TextEditingController _cityController = TextEditingController();
  late final TextEditingController _areaController = TextEditingController();
  late final StreamSubscription _addressSubscription;
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _addressSubscription = context
        .read<AddressViewModel>()
        .uiEventsStream
        .listen((event) {
          if (!mounted) return;
          if (event is AddAddressEvent) {
            Toast.showToast(context, "address.address_added_success".tr());
            Navigator.of(context).pop();
          }
        });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.locale.languageCode == 'en'
        ? context.read<AddressViewModel>().loadInitialData('en')
        : context.read<AddressViewModel>().loadInitialData('ar');

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _recipientController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _addressSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("address.address".tr())),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 24,
              children: [
               const MapPreview(),
                _addressField(),
                _phoneField(),
                _recipientField(),
                GovernmentAddress(
                  cityController: _cityController,
                  areaController: _areaController,
                ),
                _saveAddressBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _saveAddressBtn() => ElevatedButton(
    onPressed: () {
      if (!_formKey.currentState!.validate()) {
        Toast.showToast(context, "address.fill_all_fields".tr());
        return;
      }

      final location = context.read<AddressViewModel>().state.location;

      if (location?.data == null) {
        Toast.showToast(context, "address.select_location".tr());
        return;
      }

      AddressRequestEntity address = AddressRequestEntity(
        street: _addressController.value.text,
        phone: _phoneController.value.text,
        city: _cityController.value.text,
        username: _recipientController.value.text,
        lat: location?.data?.latitude.toString(),
        long: location?.data?.longitude.toString(),
      );

      context.read<AddressViewModel>().doIntent(AddAddressEvent(address));
      _clearFields();
    },
    child: Text("address.save_address".tr()),
  );
  _clearFields() {
    _addressController.clear();
    _phoneController.clear();
    _recipientController.clear();
    _cityController.clear();
    _areaController.clear();
  }

  

 Widget _recipientField() => TextFormField(
    controller: _recipientController,
    decoration: InputDecoration(
      hintText: "address.enter_recipient_name".tr(),
      label: Text("address.recipient_name".tr()),
    ),
    validator: AppValidator.validateRecipientName,
  );

  Widget _phoneField() => TextFormField(
    controller: _phoneController,
    keyboardType: TextInputType.phone,
    decoration: InputDecoration(
      hintText: "address.enter_phone_number".tr(),
      label: Text("address.phone_number".tr()),
    ),
    validator: AppValidator.validatePhone,
  );

 Widget _addressField() => TextFormField(
    controller: _addressController,
    decoration: InputDecoration(
      hintText: "address.enter_address".tr(),
      label: Text("address.address".tr()),
    ),
    validator: AppValidator.validateAddress,
  );
}
