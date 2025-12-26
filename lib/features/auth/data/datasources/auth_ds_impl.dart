import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/api/models/response/signup_response.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/features/auth/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final ApiClient _apiClient;

  const AuthDataSourceImpl(this._apiClient);

  @override
  Future<Result<ResetPasswordResponse>> resetPassword({
    required ResetPasswordRequest resetPasswordRequest,
  }) => executeApi(() async {
    var response = await _apiClient.resetPassword(
      resetPasswordRequest: resetPasswordRequest,
    );
    return response;
  });

  @override
  Future<Result<UserDto>> signUp(UserSignupRequest request) async {
    return executeApi<UserDto>(() async {
      final SignupResponse signupResponse = await _apiClient.signUp(request);
      return signupResponse.userDto ?? UserDto();
    });
  }

  @override
  Future<Result<SendResetPasswordCodeResponse>> sendResetPasswordCode({
    required SendResetPasswordCodeRequest sendResetPasswordCodeRequest,
  }) => executeApi(() async {
    var response = await _apiClient.sendResetPasswordCode(
      sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
    );
    return response;
  });

  @override
  Future<Result<VerifyResetCodeResponse>> verifyResetPasswordCode({
    required VerifyResetCodeRequest verifyResetCodeRequest,
  }) => executeApi(() async {
    var response = await _apiClient.verifyResetPasswordCode(
      verifyResetCodeRequest: verifyResetCodeRequest,
    );
    return response;
  });
}
