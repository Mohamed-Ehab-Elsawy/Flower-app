import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/helper/app_validator.dart';
import 'package:flower_app/features/auth/presentation/cubit/signup_event.dart';
import 'package:flower_app/features/auth/presentation/cubit/signup_states.dart';
import 'package:flower_app/features/auth/presentation/cubit/signup_viewmodel.dart';
import 'package:flower_app/features/auth/presentation/pages/custom_button.dart';
import 'package:flower_app/features/auth/presentation/pages/custom_text_from_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpViewModel signUpViewModel = getIt<SignUpViewModel>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpViewModel>(
      create: (context) => signUpViewModel,

      child: Scaffold(
        appBar: AppBar(title: Text("signup").tr()),
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
                          child: CustomTextFromField(
                            label: "First name".tr(),
                            hintText: "Enter First name".tr(),
                            controller: signUpViewModel.firstNameController,
                            validator: AppValidator.validateFirstName,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: CustomTextFromField(
                            label: "Last name".tr(),
                            hintText: "Enter last name".tr(),
                            controller: signUpViewModel.lastNameController,
                            validator: AppValidator.validateLastName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    CustomTextFromField(
                      label: "Email".tr(),
                      hintText: "Enter your email".tr(),
                      controller: signUpViewModel.emailController,
                      validator: AppValidator.validateEmail,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFromField(
                            label: "Password".tr(),
                            hintText: "Enter Password".tr(),
                            controller: signUpViewModel.passwordController,
                            validator: AppValidator.validatePassword,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: CustomTextFromField(
                            label: "Confirm password".tr(),
                            hintText: "Confirm password".tr(),
                            controller:
                                signUpViewModel.confirmPasswordController,
                            //validator: ValidatorsUtils.validateConfirmPassword(confirmPasswordController.text, password: passwordController.text),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    CustomTextFromField(
                      label: "Phone number".tr(),
                      hintText: "Enter Phone number".tr(),
                      controller: signUpViewModel.phoneController,
                      validator: AppValidator.validatePhone,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Text("Gender").tr(),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text("male"),
                            value: "male",
                            groupValue: signUpViewModel.selectedGender,
                            onChanged: (value) {
                              setState(() {
                                signUpViewModel.selectedGender = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text("female"),
                            value: "female",
                            groupValue: signUpViewModel.selectedGender,
                            onChanged: (value) {
                              setState(() {
                                signUpViewModel.selectedGender = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    BlocListener<SignUpViewModel, SignupStates>(
                      bloc: signUpViewModel,
                      listener: (context, state) {
                        final signUpState = state.signUpStates;
                        if (signUpState == null) {
                          return;
                        } else if (signUpState.errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(signUpState.errorMessage!)),
                          );
                        } else if (signUpState.data != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("account Created Successfully"),
                            ),
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.signup,
                          );
                        }
                      },
                      child: CustomButton(
                        text: 'signup'.tr(),
                        onPressed: validateSignUP,
                      ),
                    ),

                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "don't Have Acc",
                        // style: AppStyles.font16BlackW400()
                      ).tr(),
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
      UserRequest userRequest = UserRequest(
        firstName: signUpViewModel.firstNameController.text,
        lastName: signUpViewModel.lastNameController.text,
        email: signUpViewModel.emailController.text,
        password: signUpViewModel.passwordController.text,
        rePassword: signUpViewModel.confirmPasswordController.text,
        phone: signUpViewModel.phoneController.text,
        gender: signUpViewModel.genderController.text,
      );
      signUpViewModel.doIntent(SignUpEvent(userRequest: userRequest));
      // Navigator.pop(context).
    }
  }
}
