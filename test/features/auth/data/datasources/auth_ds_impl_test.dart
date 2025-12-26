import 'package:dio/dio.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/api/models/response/signup_response.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds_impl.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/features/auth/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_ds_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  // Consolidated mock and datasource instances
  late MockApiClient mockApiClient;
  late AuthDataSource authDataSource;

  // Test data
  late String email;
  late String resetCode;
  late String password;
  late String responseMessage;
  late String token;

  // Requests
  late SendResetPasswordCodeRequest sendResetPasswordCodeRequest;
  late VerifyResetCodeRequest verifyResetCodeRequest;
  late ResetPasswordRequest resetPasswordRequest;
  late UserSignupRequest userRequest;

  // Responses
  late SendResetPasswordCodeResponse sendResetPasswordCodeResponse;
  late VerifyResetCodeResponse verifyResetCodeResponse;
  late ResetPasswordResponse resetPasswordResponse;
  late UserDto userDto;
  late SignupResponse signupResponse;

  // Exception
  late DioException dioException;
  final Exception exception = Exception('Exception');

  setUp(() {
    // Initialize mock and datasource (consolidated from apiClient/mockApiClient and authDataSource/datasource)
    mockApiClient = MockApiClient();
    authDataSource = AuthDataSourceImpl(mockApiClient);

    // Initialize test data
    email = "joe@example.com";
    resetCode = "112233";
    password = "Joe!@12345678";
    responseMessage = "message";
    token = "token";

    dioException = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionError,
    );

    // Initialize requests
    sendResetPasswordCodeRequest = SendResetPasswordCodeRequest(email: email);
    verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: resetCode);
    resetPasswordRequest = ResetPasswordRequest(
      email: email,
      password: password,
    );

    userRequest = UserSignupRequest(
      gender: "male",
      firstName: "abdo",
      lastName: "abdoa",
      email: "abdo@d.com",
      password: "dd",
      rePassword: "dd",
      phone: "12345",
    );

    // Initialize responses
    sendResetPasswordCodeResponse = SendResetPasswordCodeResponse(
      message: responseMessage,
      info: "",
    );

    verifyResetCodeResponse = VerifyResetCodeResponse(message: responseMessage);

    resetPasswordResponse = ResetPasswordResponse(
      message: responseMessage,
      token: token,
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

    signupResponse = SignupResponse(
      message: "message",
      userDto: userDto,
      token: "token",
    );
  });

  group("Testing sendResetPasswordCode cases", () {
    test(
      "When i call sendResetPasswordCode it calls sendResetPasswordCode from "
      "api client and return Success result from api client "
      "and didn't call any other functions",
      () async {
        // arrange
        when(
          mockApiClient.sendResetPasswordCode(
            sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
          ),
        ).thenAnswer((_) async => sendResetPasswordCodeResponse);

        // act
        var result =
            await authDataSource.sendResetPasswordCode(
                  sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
                )
                as Success<SendResetPasswordCodeResponse>;

        // assert
        verify(
          mockApiClient.sendResetPasswordCode(
            sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockApiClient);

        expect(result.data.message, sendResetPasswordCodeResponse.message);
      },
    );

    test(
      "When i call sendResetPasswordCode it calls sendResetPasswordCode from "
      "api client and return failure result if there is an dio exception"
      "and didn't call any other functions",
      () async {
        // arrange
        when(
          mockApiClient.sendResetPasswordCode(
            sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
          ),
        ).thenThrow(dioException);

        // act
        var result = await authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        );

        // assert
        verify(
          mockApiClient.sendResetPasswordCode(
            sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockApiClient);

        expect(
          (result as Failure<SendResetPasswordCodeResponse>).errorMessage,
          "errors.connectionError",
        );
      },
    );
  });

  group("Testing verifyResetPasswordCode cases", () {
    test(
      "When i call verifyResetPasswordCode it calls verifyResetPasswordCode from "
      "api client and return Success result from api client "
      "and didn't call any other functions",
      () async {
        // arrange
        when(
          mockApiClient.verifyResetPasswordCode(
            verifyResetCodeRequest: verifyResetCodeRequest,
          ),
        ).thenAnswer((_) async => verifyResetCodeResponse);

        // act
        var result = await authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        );

        // assert
        verify(
          mockApiClient.verifyResetPasswordCode(
            verifyResetCodeRequest: verifyResetCodeRequest,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockApiClient);

        expect(
          (result as Success<VerifyResetCodeResponse>).data.message,
          verifyResetCodeResponse.message,
        );
      },
    );

    test(
      "When i call verifyResetPasswordCode it calls verifyResetPasswordCode from "
      "api client and return failure result if there is an dio exception"
      "and didn't call any other functions",
      () async {
        // arrange
        when(
          mockApiClient.verifyResetPasswordCode(
            verifyResetCodeRequest: verifyResetCodeRequest,
          ),
        ).thenThrow(dioException);

        // act
        var result = await authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        );

        // assert
        verify(
          mockApiClient.verifyResetPasswordCode(
            verifyResetCodeRequest: verifyResetCodeRequest,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockApiClient);

        expect(
          (result as Failure<VerifyResetCodeResponse>).errorMessage,
          "errors.connectionError",
        );
      },
    );
  });

  group("Testing resetPassword cases", () {
    test("When i call resetPassword it calls resetPassword from "
        "api client and return Success result from api client "
        "and didn't call any other functions", () async {
      // arrange
      when(
        mockApiClient.resetPassword(resetPasswordRequest: resetPasswordRequest),
      ).thenAnswer((_) async => resetPasswordResponse);

      // act
      var result = await authDataSource.resetPassword(
        resetPasswordRequest: resetPasswordRequest,
      );

      // assert
      verify(
        mockApiClient.resetPassword(resetPasswordRequest: resetPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);

      expect(
        (result as Success<ResetPasswordResponse>).data.message,
        resetPasswordResponse.message,
      );
    });

    test("When i call resetPassword it calls resetPassword from "
        "api client and return failure result if there is an dio exception"
        "and didn't call any other functions", () async {
      // arrange
      when(
        mockApiClient.resetPassword(resetPasswordRequest: resetPasswordRequest),
      ).thenThrow(dioException);

      // act
      var result = await authDataSource.resetPassword(
        resetPasswordRequest: resetPasswordRequest,
      );

      // assert
      verify(
        mockApiClient.resetPassword(resetPasswordRequest: resetPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);

      expect(
        (result as Failure<ResetPasswordResponse>).errorMessage,
        "errors.connectionError",
      );
    });
  });

  group("Testing signUp cases", () {
    test('when call signUp it should return Success', () async {
      // arrange
      provideDummy<Result<UserDto>>(Success<UserDto>(userDto));

      when(
        mockApiClient.signUp(userRequest),
      ).thenAnswer((_) async => signupResponse);

      // act
      final result = await authDataSource.signUp(userRequest);

      // assert
      expect(result, isA<Success<UserDto>>());
      expect(result as Success<UserDto>, isNotNull);
      expect(result.data.id, equals(userDto.id));
      expect(result.data.firstName, equals(userDto.firstName));
      expect(result.data.lastName, equals(userDto.lastName));
      expect(result.data.email, equals(userDto.email));
      expect(result.data.phone, equals(userDto.phone));
      expect(result.data.role, equals(userDto.role));
      expect(result.data.createdAt, equals(userDto.createdAt));
      expect(result.data.gender, equals(userDto.gender));
      expect(result.data.addresses, equals(userDto.addresses));
      expect(result.data.photo, equals(userDto.photo));
      expect(result.data.wishlist?.length, equals(userDto.wishlist?.length));

      verify(mockApiClient.signUp(userRequest)).called(1);
    });

    test('when call signUp it should return Failure', () async {
      // arrange
      provideDummy<Result<UserDto>>(Failure<UserDto>(exception.toString()));

      when(mockApiClient.signUp(userRequest)).thenThrow(exception);

      // act
      final result = await authDataSource.signUp(userRequest);

      // assert
      expect(result, isA<Failure<UserDto>>());
      expect(result as Failure<UserDto>, isNotNull);
      expect(result.errorMessage, equals(exception.toString()));

      verify(mockApiClient.signUp(userRequest)).called(1);
    });
  });
}
