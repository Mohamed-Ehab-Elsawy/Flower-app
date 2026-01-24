import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/requests/change_password_request.dart';
import 'package:flower_app/features/auth/data/models/response/change_password_response.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower_app/features/auth/domain/use_cases/change_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo authRepo;
  late ChangePasswordUseCase changePasswordUseCase;
  late ChangePasswordRequest changePasswordRequest;
  late ChangePasswordResponse changePasswordResponse;
  const tErrorMessage = 'Network error';
  const tSuccessMessage = 'Success';
  const tToken = 'token';
  const tMessage = 'Success';
  const tNewPassword = 'Ab@12345';
  const tPassword = 'Abc@1234';
  setUpAll(() {
    authRepo = MockAuthRepo();
    changePasswordUseCase = ChangePasswordUseCase(authRepo);
    changePasswordRequest = ChangePasswordRequest(
      password: tPassword,
      newPassword: tNewPassword,
    );
    changePasswordResponse = ChangePasswordResponse(
      message: tMessage,
      token: tToken,
    );
  });
  group('test use case success cases', () {
    test(
      'when call changePassword use case verify call changePassword from repo',
      () async {
        // arrange
        final tResponse = Success<ChangePasswordResponse>(
          changePasswordResponse,
        );
        provideDummy<Result<ChangePasswordResponse>>(tResponse);
        when(
          authRepo.changePassword(changePasswordRequest: changePasswordRequest),
        ).thenAnswer((_) async => tResponse);
        // act
        await changePasswordUseCase.changePassword(
          changePasswordRequest: changePasswordRequest,
        );
        // assert
        verify(
          authRepo.changePassword(changePasswordRequest: changePasswordRequest),
        ).called(1);
      },
    );

    test(
      'when call changePassword use case should return success result',
      () async {
        // arrange
        final tResponse = Success<ChangePasswordResponse>(
          changePasswordResponse,
        );
        provideDummy<Result<ChangePasswordResponse>>(tResponse);
        when(
          authRepo.changePassword(changePasswordRequest: changePasswordRequest),
        ).thenAnswer((_) async => tResponse);
        // act
        final result = await changePasswordUseCase.changePassword(
          changePasswordRequest: changePasswordRequest,
        );
        // assert
        expect(result, isA<Success<ChangePasswordResponse>>());
        expect(
          (result as Success<ChangePasswordResponse>).data.message,
          equals(tSuccessMessage),
        );
      },
    );
  });
  group("test use case failure cases", () {
    test("when call change password should return failure result", () async {
      // arrange
      final tResponse = Failure<ChangePasswordResponse>(tErrorMessage);
      provideDummy<Result<ChangePasswordResponse>>(tResponse);
      when(
        authRepo.changePassword(changePasswordRequest: changePasswordRequest),
      ).thenAnswer((_) async => tResponse);
      // act
      final result = await changePasswordUseCase.changePassword(
        changePasswordRequest: changePasswordRequest,
      );
      // assert
      expect(result, isA<Failure<ChangePasswordResponse>>());
      expect(
        (result as Failure<ChangePasswordResponse>).errorMessage,
        equals(tErrorMessage),
      );
    });
  });
}
