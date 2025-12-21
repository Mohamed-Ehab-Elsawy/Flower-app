import 'package:flower_app/features/auth/data/models/requesets/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/requesets/send_reset_password_code_request.dart';
import 'package:flower_app/features/auth/data/models/requesets/verify_reset_code_request.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';

abstract class AuthDataSource {
  Future<Result<SendResetPasswordCodeResponse>> sendResetPasswordCode({
    required SendResetPasswordCodeRequest sendResetPasswordCodeRequest,
  });

  Future<Result<VerifyResetCodeResponse>> verifyResetPasswordCode({
    required VerifyResetCodeRequest verifyResetCodeRequest,
  });

  Future<Result<ResetPasswordResponse>> resetPassword({
    required ResetPasswordRequest resetPasswordRequest,
  });
}
