import 'package:flower_app/features/auth/data/models/requesets/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/requesets/send_reset_password_code_request.dart';
import 'package:flower_app/features/auth/data/models/requesets/verify_reset_code_request.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _authDataSource;

  AuthRepoImpl(this._authDataSource);

  @override
  Future<Result<ResetPasswordResponse>> resetPassword({
    required ResetPasswordRequest resetPasswordRequest,
  }) =>
      _authDataSource.resetPassword(resetPasswordRequest: resetPasswordRequest);

  @override
  Future<Result<SendResetPasswordCodeResponse>> sendResetPasswordCode({
    required SendResetPasswordCodeRequest sendResetPasswordCodeRequest,
  }) => _authDataSource.sendResetPasswordCode(
    sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
  );

  @override
  Future<Result<VerifyResetCodeResponse>> verifyResetPasswordCode({
    required VerifyResetCodeRequest verifyResetCodeRequest,
  }) => _authDataSource.verifyResetPasswordCode(
    verifyResetCodeRequest: verifyResetCodeRequest,
  );
}
