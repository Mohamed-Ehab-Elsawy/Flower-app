import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';
import 'package:flower_app/features/address/presentation/view_model/address_state.dart';
import 'package:flower_app/features/address/presentation/view_model/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressViewModel, AddressState>(
      builder: (BuildContext context, state) {
        return Row(
          spacing: 16,
          children: [
            Expanded(
              child: DropdownMenu<String>(
                label: Text("address.city".tr()),
                expandedInsets: EdgeInsets.zero,
                initialSelection: state.selectedGov,
                onSelected: (String? value) {
                  context.read<AddressViewModel>().onGovernorateChanged(value);
                },
                dropdownMenuEntries: [
                  if (state.allData!.isLoaded)
                    ...?state.allData?.data!.keys.map((String key) {
                      return DropdownMenuEntry<String>(value: key, label: key);
                    })
                  else
                    DropdownMenuEntry<String>(
                      value: 'address.loading'.tr(),
                      label: 'address.loading'.tr(),
                    ),
                ],
              ),
            ),
            Expanded(
              child: DropdownMenu<String>(
                label: Text("address.area".tr()),
                enabled: state.selectedGov != null,
                dropdownMenuEntries: state.filteredCities!.isLoaded
                    ? state.filteredCities!.data!.map((CityEntity city) {
                        var name = city.getName(context);
                        return DropdownMenuEntry(value: name, label: name);
                      }).toList()
                    : state.filteredCities!.isLoading
                    ? [
                        DropdownMenuEntry<String>(
                          value: 'address.loading'.tr(),
                          label: 'address.loading'.tr(),
                          enabled: false,
                        ),
                      ]
                    : [
                        const DropdownMenuEntry<String>(
                          value: 'error',
                          label: 'Error loading cities',
                          enabled: false,
                        ),
                      ],
              ),
            ),
          ],
        );
      },
    );
  }
}
