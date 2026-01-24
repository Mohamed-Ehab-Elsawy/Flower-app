import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';

abstract interface class AppSectionsDataSource {
  Future<Result<UserDto>> getCurrentUserData();
}
