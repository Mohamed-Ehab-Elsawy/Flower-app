import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';

class Toast {
  static showToast(BuildContext context, String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: context.colors.primary,
      content: Center(child: Text(message)),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
