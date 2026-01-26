import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/features/address/presentation/view_model/address_view_model.dart';
import 'package:flower_app/features/address/presentation/widgets/address_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key});

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  @override
  void didChangeDependencies() {
    context.locale.languageCode == 'en'
        ? context.read<AddressViewModel>().loadInitialData('en')
        : context.read<AddressViewModel>().loadInitialData('ar');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("address.address".tr())),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 24,
            children: [
              Container(height: 200, color: Colors.red), // Header Placeholder
              _addressField(),
              _phoneField(),
              _recipientField(),
              const AddressDetails(),
              _saveAddressBtn(),
            ],
          ),
        ),
      ),
    );
  }

  _saveAddressBtn() =>
      ElevatedButton(onPressed: null, child: Text("address.save_address".tr()));

  _recipientField() => TextFormField(
    decoration: InputDecoration(
      hintText: "address.enter_recipient_name".tr(),
      label: Text("address.recipient_name".tr()),
    ),
  );

  _phoneField() => TextFormField(
    decoration: InputDecoration(
      hintText: "address.enter_phone_number".tr(),
      label: Text("address.phone_number".tr()),
    ),
  );

  _addressField() => TextFormField(
    decoration: InputDecoration(
      hintText: "address.enter_address".tr(),
      label: Text("address.address".tr()),
    ),
  );
}
