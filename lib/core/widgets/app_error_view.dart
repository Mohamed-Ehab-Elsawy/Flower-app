import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flutter/material.dart';

class AppErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const AppErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: context.appTheme.error),
          context.h(16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.appTheme.medium16,
          ),
          context.h(16),
          ElevatedButton(onPressed: onRetry, child: Text('retry'.tr())),
        ],
      ),
    );
  }
}
