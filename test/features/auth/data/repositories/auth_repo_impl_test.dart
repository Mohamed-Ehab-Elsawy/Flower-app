import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';
import 'package:flower_app/features/auth/data/models_dto/login/user_dto.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthDataSource])
void main() {
  late MockAuthDataSource mockAuthDataSource;
  late AuthRepoImpl authRepo;
  late LoginRequest loginRequest;
  late LoginResponseDto loginResponse;
  late Result<LoginResponseDto> response;
  setUp(() {
    // Arrange:
    mockAuthDataSource = MockAuthDataSource();
    authRepo = AuthRepoImpl(mockAuthDataSource);

    loginRequest = LoginRequest(email: "test@test.com", password: "123456");
    loginResponse = LoginResponseDto(
      userDto: UserDto(id: "1"),
      token: "abc123",
      message: "success",
    );
    response = Success(loginResponse);

    provideDummy<Result<LoginResponseDto>>(response);

    when(
      mockAuthDataSource.login(loginRequest: loginRequest),
    ).thenAnswer((_) async => response);
  });

  test("should call get login response from data source with correct params",() {
      // Act
      authRepo.login(loginRequest: loginRequest);

      // Assert
      verify(mockAuthDataSource.login(loginRequest: loginRequest)).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
    },
  );
}
