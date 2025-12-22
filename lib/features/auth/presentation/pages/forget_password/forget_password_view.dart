import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/constants/app_dimanens.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_state.dart';
import 'package:flower_app/features/auth/presentation/pages/widgets/reset_password_page.dart';
import 'package:flower_app/features/auth/presentation/pages/widgets/send_reset_code_page.dart';
import 'package:flower_app/features/auth/presentation/pages/widgets/verify_reset_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late PageController _pageController;
  late TextEditingController _emailController;
  late TextEditingController _newPasswordController;
  late TextEditingController _newPasswordConfirmationController;
  late GlobalKey<FormState> _emailFormKey;
  late GlobalKey<FormState> _resetPasswordFormKey;

  @override
  void initState() {
    super.initState();
    _initControllers();

    context.read<ForgetPasswordCubit>().uiEventsStream.listen((event) {
      switch (event) {
        case ForgetPasswordShowToastEvent():
          Toast.showToast(context, event.message);
        case NavigateToOTPEvent():
          _pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );

        case NavigateToChangePasswordEvent():
          _pageController.animateToPage(
            2,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );

        case NavigateToLoginEvent():
          Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _emailController.dispose();
    _newPasswordConfirmationController.dispose();
    _newPasswordController.dispose();
    _emailFormKey.currentState?.dispose();
    _resetPasswordFormKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        'password'.tr(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ),
    body: Padding(
      padding: AppDimensions.pagePadding,
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _getPages.length,
        itemBuilder: (BuildContext context, int index) => _getPages[index],
      ),
    ),
  );

  List<Widget> get _getPages {
    return [
      SendResetCodePage(
        onPressed: _confirmEmail,
        emailController: _emailController,
        formKey: _emailFormKey,
      ),
      VerifyResetCodePage(),
      ResetPasswordPage(
        onPressed: _resetPassword,
        passwordController: _newPasswordController,
        passwordConfirmationController: _newPasswordConfirmationController,
        formKey: _resetPasswordFormKey,
      ),
    ];
  }

  void _confirmEmail() {
    if (_emailFormKey.currentState!.validate()) {
      context.read<ForgetPasswordCubit>().doIntent(
        SendResetPasswordCodeIntent(_emailController.text),
      );
    }
  }

  void _resetPassword() {
    if (_resetPasswordFormKey.currentState!.validate()) {
      context.read<ForgetPasswordCubit>().doIntent(
        ResetPasswordIntent(_emailController.text, _newPasswordController.text),
      );
    }
  }

  void _initControllers() {
    _pageController = PageController(initialPage: 0);

    _emailController = TextEditingController();
    _newPasswordConfirmationController = TextEditingController();
    _newPasswordController = TextEditingController();

    _emailFormKey = GlobalKey<FormState>();
    _resetPasswordFormKey = GlobalKey<FormState>();
  }
}
