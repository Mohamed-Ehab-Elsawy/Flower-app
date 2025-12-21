import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flower_app/core/helper/app_validator.dart';
import 'package:flower_app/core/widgets/custom_elevated_button.dart';
import 'package:flower_app/core/widgets/custom_text_form_field.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendResetCodePage extends StatefulWidget {
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
  State<SendResetCodePage> createState() => _SendResetCodePageState();
}

class _SendResetCodePageState extends State<SendResetCodePage> {
  late Cubit<ForgetPasswordState> cubit;
  @override
  void initState() {
    cubit = context.read<ForgetPasswordCubit>();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Form(
      key: widget.formKey,
      child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (context, state) {
          switch (state) {}
          return Column(
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
                controller: widget.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => AppValidator.validateEmail(value),
              ),
              SizedBox(height: 48),
              state.isLoading == true
                  ? const CircularProgressIndicator()
                  : CustomElevatedButton(
                      textOnButton: IAppText.continueText,
                      onPressed: widget.onPressed,
                    ),
            ],
          );
        },
      ),
    ),
  );
}
