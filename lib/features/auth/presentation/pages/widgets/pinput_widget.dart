import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinputWidget extends StatelessWidget {
  const PinputWidget({
    super.key,
    required this.hasError,
    required this.isLoading,
    required this.cubit,
  });

  final bool hasError;
  final bool isLoading;
  final ForgetPasswordCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      defaultPinTheme: PinTheme(
        height: 50,
        width: 68,
        decoration: BoxDecoration(
          border: Border.all(
            color: hasError ? Colors.red : Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      focusedPinTheme: PinTheme(
        textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        height: 50,
        width: 68,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      submittedPinTheme: PinTheme(
        textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        height: 50,
        width: 68,
        decoration: BoxDecoration(
          border: Border.all(
            color: hasError ? Colors.red : context.colors.primaryFixed,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onCompleted: isLoading
          ? null
          : (pin) {
              cubit.doIntent(VerifyResetPasswordCodeIntent(pin));
            },
      keyboardType: TextInputType.number,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
    );
  }
}
