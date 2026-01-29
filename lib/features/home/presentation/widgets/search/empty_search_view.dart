import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flutter/material.dart';

class EmptySearchView extends StatelessWidget {
  const EmptySearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final gray = context.appTheme.grey;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: gray),
          context.h(16),
          Text(
            'no_result_found'.tr(),
            style: context.appTheme.medium16.copyWith(color: gray),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
