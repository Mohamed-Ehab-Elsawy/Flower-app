import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpUseCase {
  final AuthRepo repo;
  SignUpUseCase(this.repo);
  Future<Result<UserEntity>> call(UserSignupRequest request) => repo.signUp(request);
}
