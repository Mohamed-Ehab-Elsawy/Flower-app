import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flutter/material.dart';

class Toast {
  static showToast(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError
          ? context.appTheme.error
          : context.appTheme.success,
      content: Center(child: Text(message)),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<void> shodDialog({
    required BuildContext context,
    String? title,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final theme = context.appTheme;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    color: Colors.orange,
                    size: 32,
                  ),
                ),

                context.h(16),
                Text('Login Required', style: theme.semiBold24),
                context.h(8),
                Text(
                  title ?? 'Please login to continue and place your orders.',
                  textAlign: TextAlign.center,
                  style: theme.medium16.copyWith(color: theme.grey),
                ),

                context.h(24),

                // Buttons
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          context.pop();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('cancel'.tr()),
                      ),
                    ),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.pushNamedAndRemoveUntil(AppRoutes.login);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('login'.tr()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
