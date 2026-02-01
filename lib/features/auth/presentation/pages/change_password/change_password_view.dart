import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/helper/app_validator.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/auth/data/models/requests/change_password_request.dart';
import 'package:flower_app/features/auth/presentation/cubit/change_password/change_password_events.dart';
import 'package:flower_app/features/auth/presentation/cubit/change_password/change_password_state.dart';
import 'package:flower_app/features/auth/presentation/cubit/change_password/change_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _newPasswordConfirmationController;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _newPasswordConfirmationController = TextEditingController();
    context.read<ChangePasswordViewModel>().uiEventsStream.listen((event) {
      switch (event) {
        case ChangePasswordShowToastEvent():
          if (!mounted) return;
          Toast.showToast(context, event.message, isError: event.isError);
        case ChangePasswordIntent():
          ChangePasswordIntent(
            changePasswordRequest: event.changePasswordRequest,
          );

        case NavigateToEditProfileEvent():
          if (!mounted) return;
          Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("changePassword".tr(), style: context.appTheme.medium20),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.read<ChangePasswordViewModel>().doEvent(
            NavigateToEditProfileEvent(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 20,
              children: [
                TextFormField(
                  controller: _oldPasswordController,
                  validator: (value) => AppValidator.validatePassword(value),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "oldPassword".tr(),
                    hintText: 'oldPassword'.tr(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: context.appTheme.regular14,
                  ),
                ),
                TextFormField(
                  controller: _newPasswordController,
                  validator: (value) => AppValidator.validatePassword(value),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "newPassword".tr(),
                    hintText: 'newPassword'.tr(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: context.appTheme.regular14,
                  ),
                ),
                TextFormField(
                  controller: _newPasswordConfirmationController,
                  validator: (value) => AppValidator.validateConfirmPassword(
                    value,
                    _newPasswordController.text,
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "confirmPassword".tr(),
                    hintText: 'confirmPassword'.tr(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: context.appTheme.regular14,
                  ),
                ),
                BlocBuilder<ChangePasswordViewModel, ChangePasswordState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ChangePasswordViewModel>().doEvent(
                            ChangePasswordIntent(
                              changePasswordRequest: ChangePasswordRequest(
                                password: _oldPasswordController.text,
                                newPassword: _newPasswordController.text,
                              ),
                            ),
                          );
                        }
                      },
                      child: state.changePasswordState.isLoading
                          ? CircularProgressIndicator(
                              color: context.appTheme.secondary,
                            )
                          : Text("update".tr()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
