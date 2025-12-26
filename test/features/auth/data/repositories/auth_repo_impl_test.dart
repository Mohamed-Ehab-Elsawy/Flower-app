import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds_impl.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/features/auth/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthDataSourceImpl])
void main() {
  // Consolidated mock and repository instances
  late MockAuthDataSourceImpl mockAuthDataSource;
  late AuthRepo authRepo;

  // Test data
  late String email;
  late String resetCode;
  late String password;
  late String successMessage;
  late String errorMessage;

  // Requests
  late SendResetPasswordCodeRequest sendResetPasswordCodeRequest;
  late VerifyResetCodeRequest verifyResetCodeRequest;
  late ResetPasswordRequest resetPasswordRequest;
  late MockAuthDataSource mockAuthDataSource;
  late AuthRepoImpl authRepo;
  late LoginRequest loginRequest;
  late LoginResponseDto loginResponse;
  late Result<LoginResponseDto> response;
  late AuthRepoImpl mockRepo;
  late UserSignupRequest userRequest;

  // Responses
  late Result<SendResetPasswordCodeResponse> sendResetPasswordCodeResponse;
  late Result<VerifyResetCodeResponse> verifyResetCodeResponse;
  late Result<ResetPasswordResponse> resetPasswordResponse;

  // User data
  late UserDto userDto;
  late UserEntity userEntity;
  late String message;
  setUp(() {
    // Arrange:
    mockAuthDataSource = MockAuthDataSource();
    authRepo = AuthRepoImpl(mockAuthDataSource);

    loginRequest =  const LoginRequest(email: "test@test.com", password: "123456");
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
    message = "error message";

  setUpAll(() {
    // Initialize test data
    email = "joe@example.com";
    resetCode = "112233";
    password = "Joe!@12345678";
    successMessage = "success";
    errorMessage = "error";

    userRequest = UserSignupRequest(
      gender: "male",
      firstName: "abdo",
      lastName: "abdoa",
      email: "abdo@d.com",
      password: "dd",
      rePassword: "dd",
      phone: "12345",
    );

    userDto = UserDto(
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

    userEntity = UserEntity(
      id: "d",
      firstName: "abdo",
      lastName: "abdoa",
      email: "",
      phone: "12345",
      role: "role",
      addresses: [12, 45],
      gender: "male",
      photo: "ddd",
    );

    // Initialize mock and repository
    mockAuthDataSource = MockAuthDataSourceImpl();

    // Provide dummies for Result types
    provideDummy<Result<UserDto>>(Success<UserDto>(userDto));
    provideDummy<Result<UserEntity>>(Success<UserEntity>(userEntity));

  });

  setUp(() {
    authRepo = AuthRepoImpl(mockAuthDataSource);
  });

  group("Testing sendResetPasswordCode cases", () {
    test("When i call sendResetPasswordCode it calls "
        "sendResetPasswordCode from "
        "data source and return Success result from data source "
        "and didn't call any other functions", () async {
      // arrange
      sendResetPasswordCodeResponse = Success<SendResetPasswordCodeResponse>(
        SendResetPasswordCodeResponse(message: successMessage, info: "info"),
      );
      provideDummy<Result<SendResetPasswordCodeResponse>>(
        sendResetPasswordCodeResponse,
      );
      sendResetPasswordCodeRequest = SendResetPasswordCodeRequest(email: email);
      when(
        mockAuthDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).thenAnswer((_) async => sendResetPasswordCodeResponse);

      // act
      var result = await authRepo.sendResetPasswordCode(email: email);

      // assert
      verify(
        mockAuthDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
      expect(
        (result as Success<SendResetPasswordCodeResponse>).data.message,
        successMessage,
      );
    });

    test("When i call sendResetPasswordCode it calls "
        "sendResetPasswordCode from "
        "data source and return Failure result from data source "
        "and didn't call any other functions", () async {
      // arrange
      sendResetPasswordCodeResponse = Failure<SendResetPasswordCodeResponse>(
        errorMessage,
      );
      provideDummy<Result<SendResetPasswordCodeResponse>>(
        sendResetPasswordCodeResponse,
      );
      sendResetPasswordCodeRequest = SendResetPasswordCodeRequest(email: email);
      when(
        mockAuthDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).thenAnswer((_) async => sendResetPasswordCodeResponse);

      // act
      var result = await authRepo.sendResetPasswordCode(email: email);

      // assert
      verify(
        mockAuthDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
      expect(
        (result as Failure<SendResetPasswordCodeResponse>).errorMessage,
        errorMessage,
      );
    });
  });

  group("Testing verifyResetPasswordCode cases", () {
    test("When i call verifyResetPasswordCode it calls "
        "verifyResetPasswordCode from "
        "data source and return Success result from data source "
        "and didn't call any other functions", () async {
      // arrange
      verifyResetCodeResponse = Success<VerifyResetCodeResponse>(
        VerifyResetCodeResponse(message: successMessage),
      );
      provideDummy<Result<VerifyResetCodeResponse>>(verifyResetCodeResponse);
      verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: resetCode);
      when(
        mockAuthDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer((_) async => verifyResetCodeResponse);

      // act
      var result = await authRepo.verifyResetPasswordCode(resetCode: resetCode);

      // assert
      verify(
        mockAuthDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
      expect(
        (result as Success<VerifyResetCodeResponse>).data.message,
        successMessage,
      );
    });

    test("When i call verifyResetPasswordCode it calls "
        "verifyResetPasswordCode from "
        "data source and return Failure result from data source "
        "and didn't call any other functions", () async {
      // arrange
      verifyResetCodeResponse = Failure<VerifyResetCodeResponse>(errorMessage);
      provideDummy<Result<VerifyResetCodeResponse>>(verifyResetCodeResponse);
      verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: resetCode);
      when(
        mockAuthDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer((_) async => verifyResetCodeResponse);

      // act
      var result = await authRepo.verifyResetPasswordCode(resetCode: resetCode);

      // assert
      verify(
        mockAuthDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
      expect(
        (result as Failure<VerifyResetCodeResponse>).errorMessage,
        errorMessage,
      );
    });
  });

  group("Testing resetPassword cases", () {
    test("When i call resetPassword it calls "
        "resetPassword from "
        "data source and return Success result from data source "
        "and didn't call any other functions", () async {
      // arrange
      resetPasswordResponse = Success<ResetPasswordResponse>(
        ResetPasswordResponse(message: successMessage, token: "token"),
      );
      provideDummy<Result<ResetPasswordResponse>>(resetPasswordResponse);
      resetPasswordRequest = ResetPasswordRequest(
        email: email,
        password: password,
      );
      when(
        mockAuthDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).thenAnswer((_) async => resetPasswordResponse);

      // act
      var result = await authRepo.resetPassword(
        email: email,
        password: password,
      );

      // assert
      verify(
        mockAuthDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
      expect(
        (result as Success<ResetPasswordResponse>).data.message,
        successMessage,
      );
    });

    test("When i call resetPassword it calls "
        "resetPassword from "
        "data source and return Failure result from data source "
        "and didn't call any other functions", () async {
      // arrange
      resetPasswordResponse = Failure<ResetPasswordResponse>(errorMessage);
      provideDummy<Result<ResetPasswordResponse>>(resetPasswordResponse);
      resetPasswordRequest = ResetPasswordRequest(
        email: email,
        password: password,
      );
      when(
        mockAuthDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).thenAnswer((_) async => resetPasswordResponse);

      // act
      var result = await authRepo.resetPassword(
        email: email,
        password: password,
      );

      // assert
      verify(
        mockAuthDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
      expect(
        (result as Failure<ResetPasswordResponse>).errorMessage,
        errorMessage,
      );
    });
  });

  group("Testing signUp cases", () {
    test("when signUp with Success it should return UserEntity", () async {
      // arrange
      when(
        mockAuthDataSource.signUp(userRequest),
      ).thenAnswer((_) async => Success<UserDto>(userDto));
  test("should call get login response from data source with correct params",() {
    // Act
    authRepo.login(loginRequest: loginRequest);

    // Assert
    verify(mockAuthDataSource.login(loginRequest: loginRequest)).called(1);
    verifyNoMoreInteractions(mockAuthDataSource);
  },
  );
  test("when signUp with Success it should return UserEntity", () async {
    when(
      mockAuthDataSource.signUp(userRequest),
    ).thenAnswer((_) async => Success<UserDto>(userDto));
    final result = await mockRepo.signUp(userRequest);

      // act
      final result = await authRepo.signUp(userRequest);

      // assert
      expect(result, isA<Success<UserEntity>>());
      expect(
        (result as Success<UserEntity>).data.firstName,
        equals(userEntity.firstName),
      );
      expect(result.data.lastName, equals(userEntity.lastName));
      expect(result.data.email, equals(userEntity.email));
      expect(result.data.photo, equals(userEntity.photo));
      expect(result.data.phone, equals(userEntity.phone));
      expect(
        result.data.addresses?.length,
        equals(userEntity.addresses?.length),
      );
      expect(result.data.id, equals(userEntity.id));
      expect(result.data.gender, equals(userEntity.gender));
      expect(result.data.role, equals(userEntity.role));
      verify(mockAuthDataSource.signUp(userRequest)).called(1);
    });

    test("when signUp with Failure it should return message", () async {
      // arrange
      when(
        mockAuthDataSource.signUp(userRequest),
      ).thenAnswer((_) async => Failure<UserDto>(errorMessage));

      // act
      final result = await authRepo.signUp(userRequest);

      // assert
      expect(result, isA<Failure<UserEntity>>());
      expect(
        (result as Failure<UserEntity>).errorMessage.toString(),
        equals(errorMessage),
      );
      verify(mockAuthDataSource.signUp(userRequest)).called(1);
    });
  });
}
