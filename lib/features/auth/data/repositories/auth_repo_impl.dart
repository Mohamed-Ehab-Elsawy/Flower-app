import 'package:flower_app/core/api/models/requests/reset_password_request.dart';
import 'package:flower_app/core/api/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/core/api/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _authDataSource;

  AuthRepoImpl(this._authDataSource);

  @override
  Future<Result<String>> resetPassword({
    required ResetPasswordRequest resetPasswordRequest,
  }) =>
      _authDataSource.resetPassword(resetPasswordRequest: resetPasswordRequest);

  @override
  Future<Result<String>> sendResetPasswordCode({
    required SendResetPasswordCodeRequest sendResetPasswordCodeRequest,
  }) => _authDataSource.sendResetPasswordCode(
    sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
  );

  @override
  Future<Result<String>> verifyResetPasswordCode({
    required VerifyResetCodeRequest verifyResetCodeRequest,
  }) => _authDataSource.verifyResetPasswordCode(
    verifyResetCodeRequest: verifyResetCodeRequest,
  );
}
