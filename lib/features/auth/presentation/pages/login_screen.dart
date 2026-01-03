import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/helper/app_validator.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_events.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_view_model.dart';
import 'package:flower_app/features/auth/presentation/widgets/check_box_and_forget_password_widget.dart';
import 'package:flower_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flower_app/features/auth/presentation/widgets/do_not_have_an_account_and_sign_up_widget.dart';
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
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_checkFormFilled);
    passwordController.addListener(_checkFormFilled);
    context.read<LoginViewModel>().uiEventsStream.listen((event) {
      switch (event) {
        case NavigateToHome():
          if (!mounted) return;
          context.pushReplacement((AppRoutes.appSection));
        case NavigateToSignup():
          if (!mounted) return;
          context.pushName(AppRoutes.signup);
        case NavigateToForgetPassword():
          if (!mounted) return;
          context.pushName(AppRoutes.forgetPassword);
        case LoginViewShowToast():
          if (!mounted) return;
          Toast.showToast(context, event.message, isError: event.isError);
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: true,
    appBar: AppBar(
      title: Text(IAppText.login, style: context.appTheme.medium20),
    ),
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
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 24),
              CustomTextFromField(
                controller: passwordController,
                validator: AppValidator.validatePassword,
                label: IAppText.password,
                hintText: IAppText.enterYouPassword,
               
                isObscureText: true,
                onFieldSubmitted: (_) => _validateLogin(context),
                textInputAction: TextInputAction.done,
              ),
              CheckBoxAndForgetPasswordWidget(
                onTapForgetPassword: () => context
                    .read<LoginViewModel>()
                    .doIntent(ForgetPasswordIntent()),
              ),
              const SizedBox(height: 48),
              BlocBuilder<LoginViewModel, LoginState>(
                builder: (context, state) => ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () => _formKey.currentState!.validate()
                            ? context.read<LoginViewModel>().doIntent(
                                UserLoginIntent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              )
                            : null
                      : null,
                  child: _showLoadingOrText(state.isLoading),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                child: const Text(IAppText.continueAsGuest),
                onPressed: () =>
                    context.read<LoginViewModel>().doIntent(GuestLoginIntent()),
              ),
              const SizedBox(height: 16),
              DoNotHaveAnAccountAndSignUpWidget(
                onTapSignUp: () =>
                    context.read<LoginViewModel>().doIntent(SignupIntent()),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  void _validateLogin(context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      context.read<LoginViewModel>().doIntent(
        UserLoginIntent(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  Widget _showLoadingOrText(bool isLoading) => isLoading
      ? CircularProgressIndicator(color: context.appTheme.secondary)
      : Text(
          IAppText.login,
          style: context.appTheme.medium16.copyWith(
            color: context.appTheme.secondary,
          ),
        );

  void _checkFormFilled() {
    final shouldEnable =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    if (shouldEnable != isButtonEnabled) {
      setState(() {
        isButtonEnabled = shouldEnable;
      });
    }
  }
}
