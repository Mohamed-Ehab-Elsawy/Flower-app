import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/requests/reset_password_request.dart';
import 'package:flower_app/core/api/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/core/api/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/core/api/models/response/reset_password_response.dart';
import 'package:flower_app/core/api/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/core/api/models/response/verify_reset_code_response.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_ds_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late AuthDataSource authDataSource;
  late ApiClient apiClient;
  // filling data
  late String email;
  late String resetCode;
  late String password;
  late String responseMessage;
  late String token;
  // requests
  late SendResetPasswordCodeRequest sendResetPasswordCodeRequest;
  late VerifyResetCodeRequest verifyResetCodeRequest;
  late ResetPasswordRequest resetPasswordRequest;
  // responses
  late SendResetPasswordCodeResponse sendResetPasswordCodeResponse;
  late VerifyResetCodeResponse verifyResetCodeResponse;
  late ResetPasswordResponse resetPasswordResponse;

  setUpAll(() {
    apiClient = MockApiClient();
    email = "joe@example.com";
    resetCode = "112233";
    password = "Joe!@12345678";
    responseMessage = "message";
    token = "token";
  });

  setUp(() {
    authDataSource = AuthDataSourceImpl(apiClient);
    // requests
    sendResetPasswordCodeRequest = SendResetPasswordCodeRequest(email: email);
    verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: resetCode);
    resetPasswordRequest = ResetPasswordRequest(
      email: email,
      password: password,
    );
    // responses
    sendResetPasswordCodeResponse = SendResetPasswordCodeResponse(
      message: responseMessage,
      info: "",
    );
    verifyResetCodeResponse = VerifyResetCodeResponse(message: responseMessage);
    resetPasswordResponse = ResetPasswordResponse(
      message: responseMessage,
      token: token,
    );
  });

  group("Testing sendResetPasswordCode cases", () {
    test(
      "When i call sendResetPasswordCode it calls sendResetPasswordCode from "
      "api client and return result from api client "
      "and didn't call any other functions",
      () {
        // arrange
        when(
          apiClient.sendResetPasswordCode(
            sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
          ),
        ).thenAnswer((_) async => sendResetPasswordCodeResponse);
        // act
        authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        );
        // assert
        verify(
          apiClient.sendResetPasswordCode(
            sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
          ),
        ).called(1);
        verifyNoMoreInteractions(apiClient);
      },
    );
  });

  group("Testing verifyResetPasswordCode cases", () {
    test(
      "When i call verifyResetPasswordCode it calls verifyResetPasswordCode from "
      "api client and return result from api client "
      "and didn't call any other functions",
      () {
        // arrange
        when(
          apiClient.verifyResetPasswordCode(
            verifyResetCodeRequest: verifyResetCodeRequest,
          ),
        ).thenAnswer((_) async => verifyResetCodeResponse);
        // act
        authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        );
        // assert
        verify(
          apiClient.verifyResetPasswordCode(
            verifyResetCodeRequest: verifyResetCodeRequest,
          ),
        ).called(1);
        verifyNoMoreInteractions(apiClient);
      },
    );
  });

  group("Testing resetPassword cases", () {
    test("When i call resetPassword it calls resetPassword from "
        "api client and return result from api client "
        "and didn't call any other functions", () {
      // arrange
      when(
        apiClient.resetPassword(resetPasswordRequest: resetPasswordRequest),
      ).thenAnswer((_) async => resetPasswordResponse);
      // act
      authDataSource.resetPassword(resetPasswordRequest: resetPasswordRequest);
      // assert
      verify(
        apiClient.resetPassword(resetPasswordRequest: resetPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(apiClient);
    });
  });
}
