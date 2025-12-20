import 'package:flower_app/core/api/models/requesets/reset_password_request.dart';
import 'package:flower_app/core/api/models/requesets/send_reset_password_code_request.dart';
import 'package:flower_app/core/api/models/requesets/verify_reset_code_request.dart';
import 'package:flower_app/core/error_handling/result.dart';

abstract class AuthDataSource {
  Future<Result<String>> sendResetPasswordCode({
    required SendResetPasswordCodeRequest sendResetPasswordCodeRequest,
  });

  Future<Result<String>> verifyResetPasswordCode({
    required VerifyResetCodeRequest verifyResetCodeRequest,
  });

  Future<Result<String>> resetPassword({
    required ResetPasswordRequest resetPasswordRequest,
  });
}
