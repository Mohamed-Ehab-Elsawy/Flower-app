import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/constants/app_dimensions.dart';
import 'package:flower_app/features/terms/presentation/terms_widgets_keys.dart';
import 'package:flutter/material.dart';

class TermsErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const TermsErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
    key: const Key(TermsWidgetsKeys.center),
    child: Padding(
      key: const Key(TermsWidgetsKeys.viewPadding),
      padding: AppDimensions.pagePadding,
      child: Column(
        key: const Key(TermsWidgetsKeys.errorViewColumn),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            key: const Key(TermsWidgetsKeys.errorIcon),
            Icons.error_outline,
            color: context.appTheme.error,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            key: const Key(TermsWidgetsKeys.errorMessageText),
            message,
            textAlign: TextAlign.center,
            style: context.appTheme.medium16,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            key: const Key(TermsWidgetsKeys.retryButton),
            onPressed: onRetry,
            child: Text(
              key: const Key(TermsWidgetsKeys.retryText),
              "retry".tr(),
            ),
          ),
        ],
      ),
    ),
  );
}
