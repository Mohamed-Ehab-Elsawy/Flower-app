import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/requesets/send_reset_password_code_request.dart';
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
  late SendResetPasswordCodeUseCase useCae;
  late String email;
  late String responseMessage;
  late String errorMessageResponse;
  late SendResetPasswordCodeRequest sendResetPasswordCodeRequest;
  late Result<SendResetPasswordCodeResponse> sendResetPasswordCodeResponse;

  setUp(() {
    authRepo = MockAuthRepoImpl();
    useCae = SendResetPasswordCodeUseCase(authRepo);
    email = "joe@example.com";
    responseMessage = "success";
    errorMessageResponse = "error";
    sendResetPasswordCodeRequest = SendResetPasswordCodeRequest(email: email);
  });

  test(
    "Test when call sendResetPasswordCode it calls sendResetPasswordCode from "
    "repo and return Success result from repo and didn't call any other functions"
    "and return success message",
    () async {
      // arrange
      final successResponse = Success<SendResetPasswordCodeResponse>(
        SendResetPasswordCodeResponse(message: responseMessage, info: 'info'),
      );
      sendResetPasswordCodeResponse = successResponse;
      provideDummy<Result<SendResetPasswordCodeResponse>>(
        sendResetPasswordCodeResponse,
      );
      when(
        authRepo.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).thenAnswer((_) async => sendResetPasswordCodeResponse);

      // act
      var result = await useCae.call(
        sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
      );

      // assert
      verify(
        authRepo.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).called(1);
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
        authRepo.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).thenAnswer((_) async => sendResetPasswordCodeResponse);

      // act
      var result = await useCae.call(
        sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
      );

      // assert
      verify(
        authRepo.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authRepo);
      expect(
        (result as Failure<SendResetPasswordCodeResponse>).errorMessage,
        errorMessageResponse,
      );
    },
  );
}
