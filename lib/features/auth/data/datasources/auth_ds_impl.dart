import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/requests/reset_password_request.dart';
import 'package:flower_app/core/api/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/core/api/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final ApiClient _apiClient;

  AuthDataSourceImpl(this._apiClient);

  @override
  Future<Result<String>> resetPassword({
    required ResetPasswordRequest resetPasswordRequest,
  }) => executeApi(() async {
    var response = await _apiClient.resetPassword(
      resetPasswordRequest: resetPasswordRequest,
    );
    return response.message;
  });

  @override
  Future<Result<String>> sendResetPasswordCode({
    required SendResetPasswordCodeRequest sendResetPasswordCodeRequest,
  }) => executeApi(() async {
    var response = await _apiClient.sendResetPasswordCode(
      sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
    );
    return response.message;
  });

  @override
  Future<Result<String>> verifyResetPasswordCode({
    required VerifyResetCodeRequest verifyResetCodeRequest,
  }) => executeApi(() async {
    var response = await _apiClient.verifyResetPasswordCode(
      verifyResetCodeRequest: verifyResetCodeRequest,
    );
    return response.message;
  });
}
