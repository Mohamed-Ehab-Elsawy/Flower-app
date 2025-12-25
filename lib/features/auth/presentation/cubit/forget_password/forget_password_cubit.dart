import 'dart:async';

import 'package:flower_app/features/auth/domain/use_cases/forget_password/reset_password_use_case.dart';
import 'package:flower_app/features/auth/domain/use_cases/forget_password/send_reset_password_code_use_case.dart';
import 'package:flower_app/features/auth/domain/use_cases/forget_password/verify_reset_password_code_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final SendResetPasswordCodeUseCase _sendResetPasswordCodeUseCase;
  final VerifyResetPasswordCodeUseCase _verifyResetPasswordCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgetPasswordCubit(
    this._sendResetPasswordCodeUseCase,
    this._verifyResetPasswordCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(const ForgetPasswordState());

  void doIntent(ForgetPasswordIntent intent) {
    switch (intent) {
      case SendResetPasswordCodeIntent():
        _sendResetPasswordCode(intent.email);

      case VerifyResetPasswordCodeIntent():
        _verifyResetPasswordCode(intent.resetCode);

      case ResetPasswordIntent():
        _resetPassword(intent.email, intent.password);
    }
  }

  Future<void> _sendResetPasswordCode(String email) async {}

  Future<void> _verifyResetPasswordCode(String code) async {}

  Future<void> _resetPassword(String email, String password) async {}
}
