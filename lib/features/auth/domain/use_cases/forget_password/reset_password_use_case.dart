import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _authRepo;

  const ResetPasswordUseCase(this._authRepo);

  Future<Result<ResetPasswordResponse>> call({
    required String email,
    password,
  }) => _authRepo.resetPassword(email: email, password: password);
}
