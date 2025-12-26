import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';

class Toast {
  static showToast(BuildContext context, String message,{bool isError = false}) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ?context.colors.error : context.colors.tertiary,
      content: Center(child: Text(message)),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
