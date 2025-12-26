import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  test("when call Login it should call repo with correct params ", ()  {

    // Arrange
    final  loginResponse = LoginResponseDto(
        userDto: UserDto(id: "1"),
        token: "abc123",
        message: "success"
    );
    var response = Success(loginResponse);
    provideDummy<Result<LoginResponseDto>>(response);
    const LoginRequest loginRequest = LoginRequest(email: "test@test.com", password: "123456");
    var authRepo = MockAuthRepo();
    when(authRepo.login(loginRequest: loginRequest)).thenAnswer(
          (realInvocation) => Future.value(response));
    var useCase = LoginUseCase(authRepo);

    // Act
     useCase.login(loginRequest: loginRequest);

    // Assertion and Verification
    verify(authRepo.login(loginRequest: loginRequest));

  });
}