import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/api/models/response/signup_response.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error_handling/execute_api.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl extends AuthDataSource {
  ApiClient api;
  AuthDataSourceImpl(this.api);

  @override
  Future<Result<UserDto>> signUp(UserSignupRequest request) async {
    return executeApi<UserDto>(() async {
      final SignupResponse signupResponse = await api.signUp(request);
      return signupResponse.userDto ?? UserDto();
  });
}}
