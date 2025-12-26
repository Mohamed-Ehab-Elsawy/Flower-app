import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';

abstract class AuthRepo {
  Future<Result<LoginResponseDto>> login({required LoginRequest loginRequest});
  Future<Result<UserEntity>> signUp(UserSignupRequest request);

}
