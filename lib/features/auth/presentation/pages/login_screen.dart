import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/app_validator.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_events.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_view_model.dart';
import 'package:flower_app/features/auth/presentation/widgets/check_box_and_forget_password_widget.dart';
import 'package:flower_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flower_app/features/auth/presentation/widgets/do_not_have_an_account_and_sign_up_widget.dart';
import 'package:flower_app/features/auth/presentation/widgets/login_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LoginViewModel _viewModel = getIt<LoginViewModel>();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_checkFormFilled);
    passwordController.addListener(_checkFormFilled);
  }

  void _checkFormFilled() {
    final shouldEnable =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    if (shouldEnable != isButtonEnabled) {
      setState(() {
        isButtonEnabled = shouldEnable;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text(IAppText.login, style: context.theme.headlineMedium)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  CustomTextFromField(
                    controller: emailController,
                    validator: AppValidator.validateEmail,
                    label: IAppText.email,
                    hintText: IAppText.enterYouEmail,
                    hintStyle: context.theme.bodyMedium,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 24),
                  CustomTextFromField(
                    controller: passwordController,
                    validator: AppValidator.validatePassword,
                    label: IAppText.password,
                    hintText: IAppText.enterYouPassword,
                    hintStyle: context.theme.bodyMedium,
                    isObscureText: true,
                    onFieldSubmitted: (_) => validateLogin(context),
                    textInputAction: TextInputAction.done,
                  ),
                  CheckBoxAndForgetPasswordWidget(onTapForgetPassword: () {}),
                  const SizedBox(height: 48),
                  BlocBuilder<LoginViewModel,LoginStates>(
                    builder: (context, state) {
                      final isLoading = state.login.isLoading;
                      return ElevatedButton(
                        onPressed: isButtonEnabled ? () => validateLogin(context) : null,
                        child: _showLoadingOrText(isLoading),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    child: Text(IAppText.continueAsGuest),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  DoNotHaveAnAccountAndSignUpWidget(onTapSignUp: () {}),
                  const LoginBlocListener(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateLogin(context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      _viewModel.doIntent(
        Login(email: emailController.text, password: passwordController.text),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget _showLoadingOrText(bool isLoading) {
    return isLoading
        ? CircularProgressIndicator(color: context.colors.secondary)
        : Text(IAppText.login, style: context.theme.titleMedium?.copyWith(
              color: context.colors.secondary,
            ),
          );
  }
}
