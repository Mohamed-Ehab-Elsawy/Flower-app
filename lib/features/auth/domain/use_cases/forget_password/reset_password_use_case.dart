import 'package:flower_app/core/api/models/requesets/reset_password_request.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _authRepo;

  ResetPasswordUseCase(this._authRepo);

  Future<Result<String>> call({
    required ResetPasswordRequest resetPasswordRequest,
  }) => _authRepo.resetPassword(resetPasswordRequest: resetPasswordRequest);
}
