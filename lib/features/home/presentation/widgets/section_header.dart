import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.onPressed});
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(title.tr(), style: theme.medium20.copyWith(fontSize: 18)),
          const Spacer(),
          TextButton(
            onPressed: onPressed,
            child: Text(
              'home.view_all'.tr(),
              style: theme.medium13.copyWith(
                fontSize: 12,
                color: theme.primary,
                decoration: TextDecoration.underline,
                decorationColor: theme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
