import 'package:flower_app/features/auth/data/models/requesets/verify_reset_code_request.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyResetPasswordCodeUseCase {
  final AuthRepo _authRepo;

  VerifyResetPasswordCodeUseCase(this._authRepo);

  Future<Result<VerifyResetCodeResponse>> call({
    required VerifyResetCodeRequest verifyResetCodeRequest,
  }) => _authRepo.verifyResetPasswordCode(
    verifyResetCodeRequest: verifyResetCodeRequest,
  );
}
