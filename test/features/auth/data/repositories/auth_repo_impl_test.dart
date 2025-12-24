import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';
@GenerateMocks([AuthDataSource])
void main() {
  test("when call auth repo it should call get login response from data source with correct params ", () {

    // Arrange

    final LoginRequest loginRequest = LoginRequest(email: "test@test.com", password: "123456");
    final  loginResponse = LoginResponse(
        user: User(id: "1"),
        token: "abc123",
        message: "success"
    );
    var response = Success(loginResponse);
    provideDummy<Result<LoginResponse>>(response);
    var authDataSource = MockAuthDataSource();
    when(authDataSource.login(loginRequest: loginRequest)).thenAnswer((_) => Future.value(response),);

    var authRepo = AuthRepoImpl(authDataSource);

    // Act
    authRepo.login(loginRequest: loginRequest);
    // Assertion and Verification
    verify(authDataSource.login(loginRequest: loginRequest));

  });
}