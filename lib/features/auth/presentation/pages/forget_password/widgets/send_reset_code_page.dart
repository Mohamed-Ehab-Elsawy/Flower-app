import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flutter/material.dart';

class SendResetCodePage extends StatelessWidget {
  final void Function()? onPressed;
  final TextEditingController emailController;
  final GlobalKey<FormState>? formKey;

  const SendResetCodePage({
    super.key,
    this.onPressed,
    required this.emailController,
    this.formKey,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 40),
          Text(
            IAppText.forgetPassword,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 16),
          Text(
            IAppText.enterEmailDescription,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 32),
          // Email
          SizedBox(height: 48),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(IAppText.continueText),
          ),
        ],
      ),
    ),
  );
}
