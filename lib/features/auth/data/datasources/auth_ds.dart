import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response.dart';

abstract class AuthDataSource {
  Future<Result<LoginResponse>> login({required LoginRequest loginRequest});
}
