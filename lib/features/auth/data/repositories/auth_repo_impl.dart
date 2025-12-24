import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  AuthDataSource authDataSource;
  AuthRepoImpl(this.authDataSource);
  @override
  Future<Result<UserEntity>> signUp(UserRequest request) async {
    Result<UserDto> userDtoResponse = await authDataSource.signUp(request);
    switch (userDtoResponse) {
      case Success<UserDto>():
        {
          UserDto userDto = userDtoResponse.data;
          UserEntity users = userDto.toEntity();
          return Success<UserEntity>(users);
        }

      case Failure<UserDto>():
        {
          return Failure<UserEntity>(userDtoResponse.errorMessage);
        }
    }
  }
}
