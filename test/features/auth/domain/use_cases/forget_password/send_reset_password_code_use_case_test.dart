import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower_app/features/auth/domain/use_cases/forget_password/send_reset_password_code_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepoImpl])
void main() {
  late AuthRepo authRepo;
  late SendResetPasswordCodeUseCase sendResetPasswordUseCae;
  late String email;
  late String responseMessage;
  late String errorMessageResponse;
  late Result<SendResetPasswordCodeResponse> sendResetPasswordCodeResponse;

  setUp(() {
    authRepo = MockAuthRepoImpl();
    sendResetPasswordUseCae = SendResetPasswordCodeUseCase(authRepo);
    email = "joe@example.com";
    responseMessage = "success";
    errorMessageResponse = "error";
  });

  test(
    "Test when call sendResetPasswordCode it calls sendResetPasswordCode from "
    "repo and return Success result from repo and didn't call any other functions"
    "and return success message",
    () async {
      // arrange
      sendResetPasswordCodeResponse = Success<SendResetPasswordCodeResponse>(
        SendResetPasswordCodeResponse(message: responseMessage, info: "info"),
      );
      provideDummy<Result<SendResetPasswordCodeResponse>>(
        sendResetPasswordCodeResponse,
      );
      when(
        authRepo.sendResetPasswordCode(email: email),
      ).thenAnswer((_) async => sendResetPasswordCodeResponse);

      // act
      var result = await sendResetPasswordUseCae.call(email: email);

      // assert
      verify(authRepo.sendResetPasswordCode(email: email)).called(1);
      verifyNoMoreInteractions(authRepo);
      expect(
        (result as Success<SendResetPasswordCodeResponse>).data.message,
        responseMessage,
      );
    },
  );

  test(
    "Test when call sendResetPasswordCode it calls sendResetPasswordCode from "
    "repo and return Failure result from repo and didn't call any other functions"
    "and return error message",
    () async {
      // arrange
      sendResetPasswordCodeResponse = Failure<SendResetPasswordCodeResponse>(
        errorMessageResponse,
      );
      provideDummy<Result<SendResetPasswordCodeResponse>>(
        sendResetPasswordCodeResponse,
      );
      when(
        authRepo.sendResetPasswordCode(email: email),
      ).thenAnswer((_) async => sendResetPasswordCodeResponse);

      // act
      var result = await sendResetPasswordUseCae.call(email: email);

      // assert
      verify(authRepo.sendResetPasswordCode(email: email)).called(1);
      verifyNoMoreInteractions(authRepo);
      expect(
        (result as Failure<SendResetPasswordCodeResponse>).errorMessage,
        errorMessageResponse,
      );
    },
  );
}
