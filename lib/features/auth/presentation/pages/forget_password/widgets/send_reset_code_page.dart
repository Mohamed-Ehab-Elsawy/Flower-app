import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flower_app/core/helper/app_validator.dart';
import 'package:flower_app/core/widgets/custom_elevated_button.dart';
import 'package:flower_app/core/widgets/custom_text_form_field.dart';
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
          CustomTextFormField(
            labelText: IAppText.enterEmail,
            hintText: IAppText.email,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => AppValidator.validateEmail(value),
          ),
          SizedBox(height: 48),
          CustomElevatedButton(
            textOnButton: IAppText.continueText,
            onPressed: onPressed,
          ),
        ],
      ),
    ),
  );
}
