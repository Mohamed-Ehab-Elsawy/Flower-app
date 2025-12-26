import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  final AuthDataSource _authDataSource;
  AuthRepoImpl(this._authDataSource);

  @override
  Future<Result<LoginResponseDto>> login({
    required LoginRequest loginRequest,
  }) async {
    var response = await _authDataSource.login(loginRequest: loginRequest);
    switch (response) {
      case Success<LoginResponseDto>():
        {
          return Success<LoginResponseDto>(response.data);
        }
      case Failure<LoginResponseDto>():
        {
          return Failure<LoginResponseDto>(response.errorMessage);
        }
    }
  }
}
