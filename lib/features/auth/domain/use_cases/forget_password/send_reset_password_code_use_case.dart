import 'package:flower_app/core/api/models/requesets/send_reset_password_code_request.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendResetPasswordCodeUseCase {
  final AuthRepo _authRepo;

  SendResetPasswordCodeUseCase(this._authRepo);

  Future<Result<String>> call({
    required SendResetPasswordCodeRequest sendResetPasswordCodeRequest,
  }) => _authRepo.sendResetPasswordCode(
    sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
  );
}
