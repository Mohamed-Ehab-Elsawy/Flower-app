import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendResetPasswordCodeUseCase {
  final AuthRepo _authRepo;

  const SendResetPasswordCodeUseCase(this._authRepo);

  Future<Result<SendResetPasswordCodeResponse>> call({required String email}) =>
      _authRepo.sendResetPasswordCode(email: email);
}
