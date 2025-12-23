import 'package:flower_app/core/api/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/core/error_handling/result.dart';
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
  late VerifyResetPasswordCodeUseCase useCae;
  late String resetCode;
  late String responseMessage;
  late String errorMessageResponse;
  late VerifyResetCodeRequest verifyResetCodeRequest;
  late Result<String> verifyResetPasswordCodeResponse;

  setUp(() {
    authRepo = MockAuthRepoImpl();
    useCae = VerifyResetPasswordCodeUseCase(authRepo);
    resetCode = "112233";
    responseMessage = "success";
    errorMessageResponse = "error";
    verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: resetCode);
  });

  test(
    "Test when call verifyResetPasswordCode it calls verifyResetPasswordCode from "
    "repo and return Success result from repo and didn't call any other functions"
    "and return success message",
    () async {
      // arrange
      verifyResetPasswordCodeResponse = Success<String>(responseMessage);
      provideDummy<Result<String>>(verifyResetPasswordCodeResponse);
      when(
        authRepo.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer((_) async => verifyResetPasswordCodeResponse);

      // act
      var result = await useCae.call(
        verifyResetCodeRequest: verifyResetCodeRequest,
      );

      // assert
      verify(
        authRepo.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authRepo);
      expect((result as Success<String>).data, responseMessage);
    },
  );

  test(
    "Test when call verifyResetPasswordCode it calls verifyResetPasswordCode from "
    "repo and return Failure result from repo and didn't call any other functions"
    "and return error message",
    () async {
      // arrange
      verifyResetPasswordCodeResponse = Failure<String>(errorMessageResponse);
      provideDummy<Result<String>>(verifyResetPasswordCodeResponse);
      when(
        authRepo.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer((_) async => verifyResetPasswordCodeResponse);

      // act
      var result = await useCae.call(
        verifyResetCodeRequest: verifyResetCodeRequest,
      );

      // assert
      verify(
        authRepo.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authRepo);
      expect((result as Failure<String>).errorMessage, errorMessageResponse);
    },
  );
}
