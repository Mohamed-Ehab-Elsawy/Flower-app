import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds_impl.dart';
import 'package:flower_app/features/auth/data/models/requests/change_password_request.dart';
import 'package:flower_app/features/auth/data/models/response/change_password_response.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/features/auth/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';
import 'package:flower_app/features/auth/data/models_dto/logout/logout_response_dto.dart';
import 'package:flower_app/features/auth/domain/models/logout_response_entity.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthDataSourceImpl])
void main() {
  late MockAuthDataSourceImpl mockAuthDataSource;
  late AuthRepoImpl authRepo;
  late LoginRequest loginRequest;
  late LoginResponseDto loginResponse;
  late Result<LoginResponseDto> response;
  late UserSignupRequest userRequest;
  late UserDto userDto;
  late UserEntity userEntity;
  late String message;
  late AuthDataSource authDataSource;
  // filling data
  late String email;
  late String resetCode;
  late String password;
  late String token;
  late String newPassword;
  late String responseMessage;
  late String errorMessageResponse;

  // requests
  late SendResetPasswordCodeRequest sendResetPasswordCodeRequest;
  late VerifyResetCodeRequest verifyResetCodeRequest;
  late ResetPasswordRequest resetPasswordRequest;
  late ChangePasswordRequest changePasswordRequest;
  // responses
  late Result<SendResetPasswordCodeResponse> sendResetPasswordCodeResponse;
  late Result<VerifyResetCodeResponse> verifyResetCodeResponse;
  late Result<ResetPasswordResponse> resetPasswordResponse;
  LogoutResponseDto logoutResponseDto;
  LogoutResponseEntity logoutResponseEntit;
  late Result<ChangePasswordResponse> changePasswordResponse;

  setUpAll(() {
    authDataSource = MockAuthDataSourceImpl();
    email = "joe@example.com";
    resetCode = "112233";
    password = "Joe!@12345678";
    newPassword = "Abd@1234";
    responseMessage = "success";
    errorMessageResponse = "error";
    userRequest = UserSignupRequest(
      gender: "male",
      firstName: "abdo",
      lastName: "abdoa",
      email: "abdo@d.com",
      password: "dd",
      rePassword: "dd",
      phone: "12345",
    );
    token = "token";
  });

  setUp(() {
    mockAuthDataSource = MockAuthDataSourceImpl();
    authRepo = AuthRepoImpl(mockAuthDataSource);
    // Ensure tests stub/verify the same mock instance
    authDataSource = mockAuthDataSource;

    loginRequest = const LoginRequest(
      email: "test@test.com",
      password: "123456",
    );
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
    logoutResponseDto = LogoutResponseDto(message: "success");
    provideDummy<Result<LogoutResponseDto>>(
      Success<LogoutResponseDto>(logoutResponseDto),
    );
    logoutResponseEntit = LogoutResponseEntity(message: "success");
    provideDummy<Result<UserDto>>(Success<UserDto>(userDto));
    provideDummy<Result<UserEntity>>(Success<UserEntity>(userEntity));
    changePasswordRequest = ChangePasswordRequest(
      password: password,
      newPassword: newPassword,
    );
  });

  group("Testing sendResetPasswordCode cases", () {
    test("When i call sendResetPasswordCode it calls "
        "sendResetPasswordCode from "
        "data source and return Success result from data source "
        "and didn't call any other functions", () async {
      // arrange
      sendResetPasswordCodeResponse = Success<SendResetPasswordCodeResponse>(
        SendResetPasswordCodeResponse(message: responseMessage, info: "info"),
      );
      provideDummy<Result<SendResetPasswordCodeResponse>>(
        sendResetPasswordCodeResponse,
      );
      sendResetPasswordCodeRequest = SendResetPasswordCodeRequest(email: email);
      when(
        authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).thenAnswer((_) async => sendResetPasswordCodeResponse);
      // act
      var result = await authRepo.sendResetPasswordCode(email: email);
      // assert
      verify(
        authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(
        (result as Success<SendResetPasswordCodeResponse>).data.message,
        responseMessage,
      );
    });

    test("When i call sendResetPasswordCode it calls "
        "sendResetPasswordCode from "
        "data source and return Failure result from data source "
        "and didn't call any other functions", () async {
      // arrange
      sendResetPasswordCodeResponse = Failure<SendResetPasswordCodeResponse>(
        errorMessageResponse,
      );
      provideDummy<Result<SendResetPasswordCodeResponse>>(
        sendResetPasswordCodeResponse,
      );
      sendResetPasswordCodeRequest = SendResetPasswordCodeRequest(email: email);
      when(
        authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).thenAnswer((_) async => sendResetPasswordCodeResponse);
      // act
      var result = await authRepo.sendResetPasswordCode(email: email);
      // assert
      verify(
        authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(
        (result as Failure<SendResetPasswordCodeResponse>).errorMessage,
        errorMessageResponse,
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
        VerifyResetCodeResponse(message: responseMessage),
      );
      provideDummy<Result<VerifyResetCodeResponse>>(verifyResetCodeResponse);
      verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: resetCode);
      when(
        authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer((_) async => verifyResetCodeResponse);
      // act
      var result = await authRepo.verifyResetPasswordCode(resetCode: resetCode);
      // assert
      verify(
        authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(
        (result as Success<VerifyResetCodeResponse>).data.message,
        responseMessage,
      );
    });

    test("When i call verifyResetPasswordCode it calls "
        "verifyResetPasswordCode from "
        "data source and return Failure result from data source "
        "and didn't call any other functions", () async {
      // arrange
      verifyResetCodeResponse = Failure<VerifyResetCodeResponse>(
        errorMessageResponse,
      );
      provideDummy<Result<VerifyResetCodeResponse>>(verifyResetCodeResponse);
      verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: resetCode);
      when(
        authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer((_) async => verifyResetCodeResponse);
      // act
      var result = await authRepo.verifyResetPasswordCode(resetCode: resetCode);
      // assert
      verify(
        authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(
        (result as Failure<VerifyResetCodeResponse>).errorMessage,
        errorMessageResponse,
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
        ResetPasswordResponse(message: responseMessage, token: "token"),
      );
      provideDummy<Result<ResetPasswordResponse>>(resetPasswordResponse);
      resetPasswordRequest = ResetPasswordRequest(
        email: email,
        password: password,
      );
      when(
        authDataSource.resetPassword(
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
        authDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(
        (result as Success<ResetPasswordResponse>).data.message,
        responseMessage,
      );
    });

    test("When i call resetPassword it calls "
        "resetPassword from "
        "data source and return Failure result from data source "
        "and didn't call any other functions", () async {
      // arrange
      resetPasswordResponse = Failure<ResetPasswordResponse>(
        errorMessageResponse,
      );
      provideDummy<Result<ResetPasswordResponse>>(resetPasswordResponse);
      resetPasswordRequest = ResetPasswordRequest(
        email: email,
        password: password,
      );
      when(
        authDataSource.resetPassword(
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
        authDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(
        (result as Failure<ResetPasswordResponse>).errorMessage,
        errorMessageResponse,
      );
    });
  });

  group("Testing signup", () {
    test("when signUp with Success it should return UserEntity", () async {
      when(
        mockAuthDataSource.signUp(userRequest),
      ).thenAnswer((_) async => Success<UserDto>(userDto));
      final result = await authRepo.signUp(userRequest);

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
      verify(authRepo.signUp(userRequest)).called(1);
    });
    test("when signUp with Failure it should return message", () async {
      when(
        mockAuthDataSource.signUp(userRequest),
      ).thenAnswer((_) async => Failure<UserDto>(message));
      final result = await authRepo.signUp(userRequest);

      expect(result, isA<Failure<UserEntity>>());
      expect(
        (result as Failure<UserEntity>).errorMessage.toString(),
        equals(message),
      );
      verify(authRepo.signUp(userRequest)).called(1);
    });
  });

  group("Testing logout", () {
    test("when logout with Success it should return Success message", () async {
      logoutResponseDto = LogoutResponseDto(message: "success");
      when(
        mockAuthDataSource.logout(),
      ).thenAnswer((_) async => Success<LogoutResponseDto>(logoutResponseDto));
      final result = await authRepo.logout();
      logoutResponseEntit = LogoutResponseEntity(message: "success");
      expect(result, isA<Success<LogoutResponseEntity>>());
      expect(
        (result as Success<LogoutResponseEntity>).data.message,
        equals(logoutResponseEntit.message),
      );
      expect(result.data.message, equals(logoutResponseDto.message));
      verify(authRepo.logout()).called(1);
    });
    test("when signUp with Failure it should return message", () async {
      provideDummy<Result<LogoutResponseDto>>(
        Failure<LogoutResponseDto>(errorMessageResponse.toString()),
      );
      when(
        mockAuthDataSource.logout(),
      ).thenAnswer((_) async => Failure<LogoutResponseDto>(message));
      final result = await authRepo.logout();

      expect(result, isA<Failure<LogoutResponseEntity>>());
      expect(
        (result as Failure<LogoutResponseEntity>).errorMessage.toString(),
        equals(message),
      );
      verify(authRepo.logout()).called(1);
    });
  });

  group('Change Password test cases', () {
    test("When i call changePassword it should return Success", () async {
      //arrange
      changePasswordResponse = Success<ChangePasswordResponse>(
        ChangePasswordResponse(message: responseMessage, token: token),
      );
      provideDummy<Result<ChangePasswordResponse>>((changePasswordResponse));
      when(
        authDataSource.changePassword(
          changePasswordRequest: changePasswordRequest,
        ),
      ).thenAnswer((_) async => changePasswordResponse);

      //act
      var result = await authRepo.changePassword(
        changePasswordRequest: changePasswordRequest,
      );
      //assert
      verify(
        authDataSource.changePassword(
          changePasswordRequest: changePasswordRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(result, isA<Success<ChangePasswordResponse>>());
    });

    test("When i call changePassword it should return Failure", () async {
      //arrange

      changePasswordResponse = Failure<ChangePasswordResponse>(
        errorMessageResponse,
      );
      provideDummy<Result<ChangePasswordResponse>>((changePasswordResponse));
      when(
        authDataSource.changePassword(
          changePasswordRequest: changePasswordRequest,
        ),
      ).thenAnswer((_) async => changePasswordResponse);

      //act
      var result = await authRepo.changePassword(
        changePasswordRequest: changePasswordRequest,
      );
      //assert
      verify(
        authDataSource.changePassword(
          changePasswordRequest: changePasswordRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(result, isA<Failure<ChangePasswordResponse>>());
    });
  });
}
