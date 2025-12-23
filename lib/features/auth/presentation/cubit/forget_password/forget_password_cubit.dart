import 'dart:async';

import 'package:flower_app/core/api/models/requests/reset_password_request.dart';
import 'package:flower_app/core/api/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/core/api/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/core/error_handling/result.dart';
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

  final _uiEventsController =
      StreamController<ForgetPasswordUIEvents>.broadcast();
  Stream<ForgetPasswordUIEvents> get uiEventsStream =>
      _uiEventsController.stream;

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

  Future<void> _sendResetPasswordCode(String email) async {
    // emit Loading

    final result = await _sendResetPasswordCodeUseCase(
      sendResetPasswordCodeRequest: SendResetPasswordCodeRequest(email: email),
    );

    switch (result) {
      case Success<String>():
      // TODO

      case Failure<String>():
      // TODO
    }
  }

  Future<void> _verifyResetPasswordCode(String code) async {
    // emit Loading

    final result = await _verifyResetPasswordCodeUseCase(
      verifyResetCodeRequest: VerifyResetCodeRequest(resetCode: code),
    );

    switch (result) {
      case Success<String>():
      // TODO

      case Failure<String>():
      // TODO
    }
  }

  Future<void> _resetPassword(String email, String password) async {
    // emit Loading

    final result = await _resetPasswordUseCase(
      resetPasswordRequest: ResetPasswordRequest(
        email: email,
        password: password,
      ),
    );

    switch (result) {
      case Success<String>():
      // TODO

      case Failure<String>():
      // TODO
    }
  }
}
