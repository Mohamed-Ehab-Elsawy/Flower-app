import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepo _authRepo;
  const LoginUseCase(this._authRepo);

  Future<Result<LoginResponse>> login({required LoginRequest loginRequest}) {
    return _authRepo.login(loginRequest: loginRequest);
  }
}
