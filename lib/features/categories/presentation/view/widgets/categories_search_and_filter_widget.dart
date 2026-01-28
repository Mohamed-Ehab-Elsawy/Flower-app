import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flutter/material.dart';

class CategoriesSearchWidget extends StatelessWidget {
  const CategoriesSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var greyColor = context.appTheme.secondary[70]!;
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.search),
            child: Container(
              decoration: BoxDecoration(
                border: BoxBorder.all(color: greyColor, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 12,
                      bottom: 12,
                      right: 8,
                    ),
                    child: Icon(Icons.search_rounded, color: greyColor),
                  ),
                  Text(
                    'search'.tr(),
                    style: context.appTheme.medium16.copyWith(color: greyColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        //   decoration: BoxDecoration(
        //     border: BoxBorder.all(color: greyColor, width: 1),
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   child: Icon(Icons.filter_list, color: greyColor),
        // ),
      ],
    );
  }
}
