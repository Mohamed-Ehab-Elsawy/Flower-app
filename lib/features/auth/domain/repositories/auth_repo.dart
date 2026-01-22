import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';

abstract interface class AuthRepo {
  Future<Result<LoginResponseDto>> login({required LoginRequest loginRequest});
  Future<Result<UserEntity>> signUp(UserSignupRequest request);

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

  Future<Result<LogoutResponseEntity>> logout();
}
