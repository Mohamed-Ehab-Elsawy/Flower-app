import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/requests/change_password_request.dart';
import 'package:flower_app/features/auth/data/models/response/change_password_response.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final AuthRepo authRepo;

  ChangePasswordUseCase(this.authRepo);

  Future<Result<ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest changePasswordRequest,
  }) {
    return authRepo.changePassword(
      changePasswordRequest: changePasswordRequest,
    );
  }
}
