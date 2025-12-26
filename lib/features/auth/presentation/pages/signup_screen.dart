import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/helper/app_validator.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/auth/presentation/cubit/signup_event.dart';
import 'package:flower_app/features/auth/presentation/cubit/signup_states.dart';
import 'package:flower_app/features/auth/presentation/cubit/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpViewModel signUpViewModel = getIt<SignUpViewModel>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    signUpViewModel.signupUiEvent.listen((event) {
      switch (event) {
        case ShowToast():
          {
            Toast.showToast(context, event.message);
          }

        case NavigateToLogin():
          {
            Navigator.pop(context);
          }

        case NavigateToLoginAfterSignup():
          {
            Navigator.pop(context);
          }
        case NavigateToTermsConditions():
          {
            Navigator.pushNamed(context, AppRoutes.terms);
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpViewModel>(
      create: (context) => signUpViewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up", style: context.theme.headlineMedium).tr(),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 12),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "First name".tr(),
                              hintText: "Enter First name".tr(),
                            ),

                            controller: firstNameController,
                            validator: AppValidator.validateFirstName,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Last name".tr(),
                              hintText: "Enter last name".tr(),
                            ),
                            controller: lastNameController,
                            validator: AppValidator.validateLastName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email".tr(),
                        hintText: "Enter your email".tr(),
                      ),

                      controller: emailController,
                      validator: AppValidator.validateEmail,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password".tr(),
                              hintText: "Enter Password".tr(),
                            ),

                            controller: passwordController,
                            validator: AppValidator.validatePassword,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Confirm password".tr(),
                              hintText: "Confirm password".tr(),
                            ),

                            validator: (value) =>
                                AppValidator.validateConfirmPassword(
                                  passwordController.text,
                                  value!,
                                ),
                            controller: confirmPasswordController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Phone number".tr(),
                        hintText: "Enter Phone number".tr(),
                      ),

                      controller: phoneController,
                      validator: AppValidator.validatePhone,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: BlocBuilder<SignUpViewModel, SignupStates>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  Text(
                                    "Gender".tr(),
                                    style: context.theme.titleMedium,
                                  ),
                                  Expanded(
                                    child: RadioListTile<String>(
                                      title: Text(
                                        "male".tr(),
                                        style: context.theme.bodyMedium,
                                      ).tr(),
                                      value: "male",
                                      groupValue: state.selectedGender ?? '',
                                      onChanged: (value) {
                                        if (value != null) {
                                          context
                                              .read<SignUpViewModel>()
                                              .doIntent(
                                                SelectGender(
                                                  selectGender: value,
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile<String>(
                                      title: Text(
                                        "female".tr(),
                                        style: context.theme.bodyMedium,
                                      ).tr(),
                                      value: "female",
                                      groupValue: state.selectedGender ?? '',
                                      onChanged: (value) {
                                        if (value != null) {
                                          context
                                              .read<SignUpViewModel>()
                                              .doIntent(
                                                SelectGender(
                                                  selectGender: value,
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "Creating an account, you agree to our ".tr(),
                          style: context.theme.bodySmall,
                        ),
                        InkWell(
                          onTap: () {
                            signUpViewModel.doEvent(
                              NavigateToTermsConditions(),
                            );
                          },
                          child: Text(
                            "Terms&Conditions".tr(),

                            style: context.theme.labelMedium?.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    BlocListener<SignUpViewModel, SignupStates>(
                      listenWhen: (previous, current) {
                        return previous.signUpState != current.signUpState;
                      },
                      listener: (context, state) {
                        final signUpState = state.signUpState;
                        if (signUpState == null) {
                          return;
                        } else if (signUpState.errorMessage != null) {
                          signUpViewModel.doEvent(
                            ShowToast(message: signUpState.errorMessage!),
                          );
                        } else if (signUpState.data != null) {
                          signUpViewModel.doEvent(
                            ShowToast(message: "account_created_success".tr()),
                          );

                          signUpViewModel.doEvent(NavigateToLoginAfterSignup());
                        }
                      },
                      child: ElevatedButton(
                        onPressed: validateSignUP,
                        child: Text('signup'.tr()),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(
                            "Already have an account? ".tr(),
                            style: context.theme.bodyLarge,
                          ),
                          InkWell(
                            onTap: () {
                              signUpViewModel.doEvent(NavigateToLogin());
                            },
                            child: Text(
                              "Login".tr(),
                              style: context.theme.titleMedium?.copyWith(
                                decoration: TextDecoration.underline,
                                color: context.colors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateSignUP() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final currentState = signUpViewModel.state;
      UserSignupRequest userRequest = UserSignupRequest(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
        rePassword: confirmPasswordController.text,
        phone: phoneController.text,
        gender: currentState.selectedGender ?? '',
      );
      signUpViewModel.doIntent(SignUpEvent(userRequest: userRequest));
    }
  }
}
