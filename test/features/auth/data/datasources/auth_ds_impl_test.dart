import 'package:dio/dio.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/handle_exception%20.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds_impl.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_ds_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  test("should return Success<LoginResponse> with correct token when login succeeds", () async {
      // Arrange
      var apiClient = MockApiClient();
      var dataSource = AuthDataSourceImpl(apiClient);
      final loginRequest = LoginRequest(email: "test@test.com", password: "123456");
      final LoginResponse loginResponse = LoginResponse(
        message: "success",
        token: "abc123",
        user: User(id: "1"),
      );

      // Act
      when(apiClient.login(loginRequest: loginRequest)).thenAnswer((_) => Future.value(loginResponse));

      var result = await dataSource.login(loginRequest: loginRequest);

      // Assert

      expect(result, isA<Success<LoginResponse>>());
      final success = result as Success<LoginResponse>;

      expect(success.data.token, equals(loginResponse.token));
      verify(apiClient.login(loginRequest: loginRequest)).called(1);
    });
  test("should return Failure when API throws DioException", () async {

    // Arrange
    final LoginRequest loginRequest = LoginRequest(email: "test@test.com", password: "123456");
    final apiClient = MockApiClient();
    final dataSource = AuthDataSourceImpl(apiClient);
    final DioException dioException = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.connectionError
    );
    when(apiClient.login(loginRequest: loginRequest)).thenThrow(dioException);
    // Act
    final result = await dataSource.login(loginRequest: loginRequest);

    // Assert
    verify(apiClient.login(loginRequest: loginRequest)).called(1);

    verifyNoMoreInteractions(apiClient);

    // expect(result, isA<Failure>());
    // final failure = result as Failure;

    expect((result as Failure).errorMessage, equals(NetworkException.getMessageError(dioException)));

  });
}
