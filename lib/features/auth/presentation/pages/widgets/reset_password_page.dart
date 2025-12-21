import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  final void Function() onPressed;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;
  final GlobalKey<FormState> formKey;

  const ResetPasswordPage({
    super.key,
    required this.onPressed,
    required this.passwordController,
    required this.passwordConfirmationController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
