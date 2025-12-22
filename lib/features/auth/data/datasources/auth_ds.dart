import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';

abstract class AuthDataSource {
  Future<Result <UserDto>> signUp(UserRequest request);


}
