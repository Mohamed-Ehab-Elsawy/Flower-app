import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/api/models/response/signup_response.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final ApiClient _apiClient;
  AuthDataSourceImpl(this._apiClient);

  @override
  Future<Result<LoginResponseDto>> login({required LoginRequest loginRequest}) async {
    return executeApi(() async {
      return await _apiClient.login(loginRequest: loginRequest);
    });
  }

  @override
  Future<Result<UserDto>> signUp(UserSignupRequest request) async {
    return executeApi<UserDto>(() async {
      final SignupResponse signupResponse = await _apiClient.signUp(request);
      return signupResponse.userDto ?? UserDto();
  });
}}

