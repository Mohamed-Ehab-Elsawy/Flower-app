
import 'package:dio/dio.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/api/models/response/signup_response.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/handle_exception%20.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds_impl.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_ds_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late AuthDataSourceImpl dataSource;
  late LoginRequest loginRequest;
  late LoginResponseDto loginResponse;
  late DioException dioException;
  late MockApiClient mockApiClient;
  late UserSignupRequest userRequest;
  late UserDto user;
  late SignupResponse dummySignupResponse;
  Exception e = Exception('Exception');

  setUp(() {
    // Arrange
    mockApiClient = MockApiClient();
    dataSource = AuthDataSourceImpl(mockApiClient);

    mockApiClient = MockApiClient();
    dataSource = AuthDataSourceImpl(mockApiClient);
    loginRequest = const LoginRequest(email: "test@test.com", password: "123456");

    loginResponse = LoginResponseDto(
      message: "success",
      token: "abc123",
      userDto: UserDto(id: "1"),
    );

    dioException = DioException(
      requestOptions: RequestOptions(path: ''),
      type: DioExceptionType.connectionError,
    );
    userRequest = UserSignupRequest(
      gender: "male",
      firstName: "abdo",
      lastName: "abdoa",
      email: "abdo@d.com",
      password: "dd",
      rePassword: "dd",
      phone: "12345",
    );
    user = UserDto(
      id: "d",
      firstName: "abdo",
      lastName: "abdoa",
      email: "",
      phone: "12345",
      role: "role",
      addresses: [12, 45],
      gender: "male",
      createdAt: "2024-01-01T00:00:00Z",
      photo: "ddd",
      wishlist: [12, 45],
    );
    dummySignupResponse = SignupResponse(
      message: "message",
      userDto: user,
      token: "token",
    );
  });

  test(
    "should return Success<LoginResponse> with correct token when login succeeds",
        () async {
      // Arrange
      when(
        mockApiClient.login(loginRequest: loginRequest),
      ).thenAnswer((_) async => loginResponse);

      // Act
      final result = await dataSource.login(loginRequest: loginRequest);

      // Assert
      expect(result, isA<Success<LoginResponseDto>>());
      final success = result as Success<LoginResponseDto>;
      expect(success.data.token, equals(loginResponse.token));
      verify(mockApiClient.login(loginRequest: loginRequest)).called(1);
      verifyNoMoreInteractions(mockApiClient);
    },
  );

  test("should return Failure when API throws DioException", () async {
    // Arrange
    when(mockApiClient.login(loginRequest: loginRequest)).thenThrow(dioException);

    // Act
    final result = await dataSource.login(loginRequest: loginRequest);

    // Assert
    verify(mockApiClient.login(loginRequest: loginRequest)).called(1);
    verifyNoMoreInteractions(mockApiClient);
    expect(
      (result as Failure).errorMessage,
      equals(NetworkException.getMessageError(dioException)),
    );
  });

  test('when call signUp it should return Success', () async {
    provideDummy<Result<UserDto>>(Success<UserDto>(user));

    when(
      mockApiClient.signUp(userRequest),
    ).thenAnswer((_) async => dummySignupResponse);
    final result = await dataSource.signUp(userRequest);
    expect(result, isA<Success<UserDto>>());
    expect(result as Success<UserDto>, isNotNull);
    expect(result.data.id, equals(user.id));
    expect(result.data.firstName, equals(user.firstName));
    expect(result.data.lastName, equals(user.lastName));
    expect(result.data.email, equals(user.email));
    expect(result.data.phone, equals(user.phone));
    expect(result.data.role, equals(user.role));
    expect(result.data.createdAt, equals(user.createdAt));
    expect(result.data.gender, equals(user.gender));
    expect(result.data.addresses, equals(user.addresses));
    expect(result.data.photo, equals(user.photo));
    expect(result.data.wishlist?.length, equals(user.wishlist?.length));
    verify(mockApiClient.signUp(userRequest)).called(1);
  });
  test('when call signUp it should return Failure', () async {
    provideDummy<Result<UserDto>>(Failure<UserDto>(e.toString()));
    when(mockApiClient.signUp(userRequest)).thenThrow(e);
    final result = await dataSource.signUp(userRequest);
    expect(result, isA<Failure<UserDto>>());
    expect(result as Failure<UserDto>, isNotNull);
    expect(result.errorMessage, equals(e.toString()));
    verify(mockApiClient.signUp(userRequest)).called(1);
  });
}
