import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/requesets/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower_app/features/auth/domain/use_cases/forget_password/reset_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepoImpl])
void main() {
  late AuthRepo authRepo;
  late ResetPasswordUseCase useCae;
  late String email;
  late String password;
  late String responseMessage;
  late String errorMessageResponse;
  late ResetPasswordRequest resetPasswordRequest;
  late Result<ResetPasswordResponse> verifyResetPasswordCodeResponse;

  setUp(() {
    authRepo = MockAuthRepoImpl();
    useCae = ResetPasswordUseCase(authRepo);
    email = "john@example.com";
    password = "joe!@12345678";
    responseMessage = "success";
    errorMessageResponse = "error";
    resetPasswordRequest = ResetPasswordRequest(
      email: email,
      password: password,
    );
  });

  test("Test when call resetPassword it calls resetPassword from "
      "repo and return Success result from repo and didn't call any other functions"
      "and return success message", () async {
    // arrange
    final resetPasswordModel = ResetPasswordResponse(
      message: responseMessage,
      token: 'token',
    );
    verifyResetPasswordCodeResponse = Success<ResetPasswordResponse>(
      resetPasswordModel,
    );
    provideDummy<Result<ResetPasswordResponse>>(
      verifyResetPasswordCodeResponse,
    );
    when(
      authRepo.resetPassword(resetPasswordRequest: resetPasswordRequest),
    ).thenAnswer((_) async => verifyResetPasswordCodeResponse);

    // act
    var result = await useCae.call(resetPasswordRequest: resetPasswordRequest);

    // assert
    verify(
      authRepo.resetPassword(resetPasswordRequest: resetPasswordRequest),
    ).called(1);
    verifyNoMoreInteractions(authRepo);
    expect(
      (result as Success<ResetPasswordResponse>).data.message,
      responseMessage,
    );
  });

  test("Test when call resetPassword it calls resetPassword from "
      "repo and return Failure result from repo and didn't call any other functions"
      "and return error message", () async {
    // arrange
    verifyResetPasswordCodeResponse = Failure<ResetPasswordResponse>(
      errorMessageResponse,
    );
    provideDummy<Result<ResetPasswordResponse>>(
      verifyResetPasswordCodeResponse,
    );
    when(
      authRepo.resetPassword(resetPasswordRequest: resetPasswordRequest),
    ).thenAnswer((_) async => verifyResetPasswordCodeResponse);

    // act
    var result = await useCae.call(resetPasswordRequest: resetPasswordRequest);

    // assert
    verify(
      authRepo.resetPassword(resetPasswordRequest: resetPasswordRequest),
    ).called(1);
    verifyNoMoreInteractions(authRepo);
    expect(
      (result as Failure<ResetPasswordResponse>).errorMessage,
      errorMessageResponse,
    );
  });
}
