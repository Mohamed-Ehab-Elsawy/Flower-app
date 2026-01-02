import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';

class CategoriesSearchAndFilterWidget extends StatelessWidget {
  const CategoriesSearchAndFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var greyColor = context.appTheme.secondary[70]!;
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_rounded, color: greyColor),
              hint: Text(
                'search'.tr(),
                style: context.appTheme.regular16.copyWith(color: greyColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: greyColor, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: greyColor, width: 1),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            border: BoxBorder.all(color: greyColor, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.filter_list, color: greyColor),
        ),
      ],
    );
  }
}
