import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/logout_response_entity.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUseCase {
  final AuthRepo _authRepo;

  const LogoutUseCase(this._authRepo);

  Future<Result<LogoutResponseEntity>> call() => _authRepo.logout();
}
