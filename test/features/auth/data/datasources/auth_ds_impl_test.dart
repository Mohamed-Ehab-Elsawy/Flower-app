import 'package:dio/dio.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/handle_exception%20.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds_impl.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';
import 'package:flower_app/features/auth/data/models_dto/login/user_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_ds_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient apiClient;
  late AuthDataSourceImpl dataSource;
  late LoginRequest loginRequest;
  late LoginResponseDto loginResponse;
  late DioException dioException;
  setUp(() {
    // Arrange
    apiClient = MockApiClient();
    dataSource = AuthDataSourceImpl(apiClient);
    loginRequest = LoginRequest(email: "test@test.com", password: "123456");

    loginResponse = LoginResponseDto(
      message: "success",
      token: "abc123",
      userDto: UserDto(id: "1"),
    );

    dioException = DioException(
      requestOptions: RequestOptions(path: ''),
      type: DioExceptionType.connectionError,
    );
  });
  test(
    "should return Success<LoginResponse> with correct token when login succeeds",
    () async {
      // Arrange
      when(
        apiClient.login(loginRequest: loginRequest),
      ).thenAnswer((_) async => loginResponse);

      // Act
      final result = await dataSource.login(loginRequest: loginRequest);

      // Assert
      expect(result, isA<Success<LoginResponseDto>>());
      final success = result as Success<LoginResponseDto>;
      expect(success.data.token, equals(loginResponse.token));
      verify(apiClient.login(loginRequest: loginRequest)).called(1);
      verifyNoMoreInteractions(apiClient);
    },
  );

  test("should return Failure when API throws DioException", () async {
    // Arrange
    when(apiClient.login(loginRequest: loginRequest)).thenThrow(dioException);

    // Act
    final result = await dataSource.login(loginRequest: loginRequest);

    // Assert
    verify(apiClient.login(loginRequest: loginRequest)).called(1);
    verifyNoMoreInteractions(apiClient);
    expect(
      (result as Failure).errorMessage,
      equals(NetworkException.getMessageError(dioException)),
    );
  });
}
