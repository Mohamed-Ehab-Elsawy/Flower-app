import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower_app/core/error_handling/result.dart';

abstract interface class AuthRepo {
  Future<Result<SendResetPasswordCodeResponse>> sendResetPasswordCode({
    required String email,
  });

  Future<Result<VerifyResetCodeResponse>> verifyResetPasswordCode({
    required String resetCode,
  });

  Future<Result<ResetPasswordResponse>> resetPassword({
    required String email,
    password,
  });
}

abstract class AuthRepo {

}
