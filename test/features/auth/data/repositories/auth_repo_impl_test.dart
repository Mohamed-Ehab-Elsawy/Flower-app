import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds_impl.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/core/api/models/requests/reset_password_request.dart';
import 'package:flower_app/core/api/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/core/api/models/requests/verify_reset_code_request.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthDataSourceImpl])
void main() {
  late AuthDataSource authDataSource;
  late AuthRepo authRepo;
  // filling data
  late String email;
  late String resetCode;
  late String password;
  late String responseMessage;
  late String errorMessageResponse;
  // requests
  late SendResetPasswordCodeRequest sendResetPasswordCodeRequest;
  late VerifyResetCodeRequest verifyResetCodeRequest;
  late ResetPasswordRequest resetPasswordRequest;
  // responses
  late Result<String> sendResetPasswordCodeResponse;
  late Result<String> verifyResetCodeResponse;
  late Result<String> resetPasswordResponse;

  setUpAll(() {
    authDataSource = MockAuthDataSourceImpl();
    email = "joe@example.com";
    resetCode = "112233";
    password = "Joe!@12345678";
    responseMessage = "success";
    errorMessageResponse = "error";
  });

  setUp(() {
    authRepo = AuthRepoImpl(authDataSource);
    // requests
    sendResetPasswordCodeRequest = SendResetPasswordCodeRequest(email: email);
    verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: resetCode);
    resetPasswordRequest = ResetPasswordRequest(
      email: email,
      password: password,
    );
  });

  group("Testing sendResetPasswordCode cases", () {
    test("When i call sendResetPasswordCode it calls "
        "sendResetPasswordCode from "
        "data source and return Success result from data source "
        "and didn't call any other functions", () async {
      // arrange
      sendResetPasswordCodeResponse = Success<String>(responseMessage);
      provideDummy<Result<String>>(sendResetPasswordCodeResponse);
      when(
        authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).thenAnswer((_) async => sendResetPasswordCodeResponse);
      // act
      var result = await authRepo.sendResetPasswordCode(
        sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
      );
      // assert
      verify(
        authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect((result as Success<String>).data, responseMessage);
    });

    test("When i call sendResetPasswordCode it calls "
        "sendResetPasswordCode from "
        "data source and return Failure result from data source "
        "and didn't call any other functions", () async {
      // arrange
      sendResetPasswordCodeResponse = Failure<String>(errorMessageResponse);
      provideDummy<Result<String>>(sendResetPasswordCodeResponse);
      when(
        authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).thenAnswer((_) async => sendResetPasswordCodeResponse);
      // act
      var result = await authRepo.sendResetPasswordCode(
        sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
      );
      // assert
      verify(
        authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect((result as Failure<String>).errorMessage, errorMessageResponse);
    });
  });

  group("Testing verifyResetPasswordCode cases", () {
    test("When i call verifyResetPasswordCode it calls "
        "verifyResetPasswordCode from "
        "data source and return Success result from data source "
        "and didn't call any other functions", () async {
      // arrange
      verifyResetCodeResponse = Success<String>(responseMessage);
      provideDummy<Result<String>>(verifyResetCodeResponse);
      when(
        authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer((_) async => verifyResetCodeResponse);
      // act
      var result = await authRepo.verifyResetPasswordCode(
        verifyResetCodeRequest: verifyResetCodeRequest,
      );
      // assert
      verify(
        authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect((result as Success<String>).data, responseMessage);
    });

    test("When i call verifyResetPasswordCode it calls "
        "verifyResetPasswordCode from "
        "data source and return Failure result from data source "
        "and didn't call any other functions", () async {
      // arrange
      verifyResetCodeResponse = Failure<String>(errorMessageResponse);
      provideDummy<Result<String>>(verifyResetCodeResponse);
      when(
        authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer((_) async => verifyResetCodeResponse);
      // act
      var result = await authRepo.verifyResetPasswordCode(
        verifyResetCodeRequest: verifyResetCodeRequest,
      );
      // assert
      verify(
        authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect((result as Failure<String>).errorMessage, errorMessageResponse);
    });
  });

  group("Testing resetPassword cases", () {
    test("When i call resetPassword it calls "
        "resetPassword from "
        "data source and return Success result from data source "
        "and didn't call any other functions", () async {
      // arrange
      resetPasswordResponse = Success<String>(responseMessage);
      provideDummy<Result<String>>(resetPasswordResponse);
      when(
        authDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).thenAnswer((_) async => resetPasswordResponse);
      // act
      var result = await authRepo.resetPassword(
        resetPasswordRequest: resetPasswordRequest,
      );
      // assert
      verify(
        authDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect((result as Success<String>).data, responseMessage);
    });

    test("When i call resetPassword it calls "
        "resetPassword from "
        "data source and return Failure result from data source "
        "and didn't call any other functions", () async {
      // arrange
      resetPasswordResponse = Failure<String>(errorMessageResponse);
      provideDummy<Result<String>>(resetPasswordResponse);
      when(
        authDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).thenAnswer((_) async => sendResetPasswordCodeResponse);
      // act
      var result = await authRepo.resetPassword(
        resetPasswordRequest: resetPasswordRequest,
      );
      // assert
      verify(
        authDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect((result as Failure<String>).errorMessage, errorMessageResponse);
    });
  });
}
