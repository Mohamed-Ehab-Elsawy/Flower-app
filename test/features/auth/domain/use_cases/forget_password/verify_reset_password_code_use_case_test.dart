import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower_app/features/auth/domain/use_cases/forget_password/verify_reset_password_code_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verify_reset_password_code_use_case_test.mocks.dart';

@GenerateMocks([AuthRepoImpl])
void main() {
  late AuthRepo authRepo;
  late VerifyResetPasswordCodeUseCase verifyResetPasswordCodeUseCase;
  late String resetCode;
  late String responseMessage;
  late String errorMessageResponse;
  late Result<VerifyResetCodeResponse> verifyResetPasswordCodeResponse;

  setUp(() {
    authRepo = MockAuthRepoImpl();
    verifyResetPasswordCodeUseCase = VerifyResetPasswordCodeUseCase(authRepo);
    resetCode = "112233";
    responseMessage = "success";
    errorMessageResponse = "error";
  });

  test(
    "Test when call verifyResetPasswordCode it calls verifyResetPasswordCode from "
    "repo and return Success result from repo and didn't call any other functions"
    "and return success message",
    () async {
      // arrange
      verifyResetPasswordCodeResponse = Success<VerifyResetCodeResponse>(
        VerifyResetCodeResponse(message: responseMessage),
      );
      provideDummy<Result<VerifyResetCodeResponse>>(
        verifyResetPasswordCodeResponse,
      );
      when(
        authRepo.verifyResetPasswordCode(resetCode: resetCode),
      ).thenAnswer((_) async => verifyResetPasswordCodeResponse);

      // act
      var result = await verifyResetPasswordCodeUseCase.call(
        resetCode: resetCode,
      );

      // assert
      verify(authRepo.verifyResetPasswordCode(resetCode: resetCode)).called(1);
      verifyNoMoreInteractions(authRepo);
      expect(
        (result as Success<VerifyResetCodeResponse>).data.message,
        responseMessage,
      );
    },
  );

  test(
    "Test when call verifyResetPasswordCode it calls verifyResetPasswordCode from "
    "repo and return Failure result from repo and didn't call any other functions"
    "and return error message",
    () async {
      // arrange
      verifyResetPasswordCodeResponse = Failure<VerifyResetCodeResponse>(
        errorMessageResponse,
      );
      provideDummy<Result<VerifyResetCodeResponse>>(
        verifyResetPasswordCodeResponse,
      );
      when(
        authRepo.verifyResetPasswordCode(resetCode: resetCode),
      ).thenAnswer((_) async => verifyResetPasswordCodeResponse);

      // act
      var result = await verifyResetPasswordCodeUseCase.call(
        resetCode: resetCode,
      );

      // assert
      verify(authRepo.verifyResetPasswordCode(resetCode: resetCode)).called(1);
      verifyNoMoreInteractions(authRepo);
      expect(
        (result as Failure<VerifyResetCodeResponse>).errorMessage,
        errorMessageResponse,
      );
    },
  );
}
