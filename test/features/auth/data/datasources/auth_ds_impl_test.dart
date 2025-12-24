import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/api/models/response/signup_response.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds_impl.dart'
    show AuthDataSourceImpl;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'auth_ds_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late AuthDataSourceImpl datasource;
  late MockApiClient mockApiClient;
  late UserRequest userRequest;
  late UserDto user;
  late SignupResponse dummySignupResponse;
  setUpAll(() {
    mockApiClient = MockApiClient();
    datasource = AuthDataSourceImpl(mockApiClient);
    userRequest = UserRequest(
      gender: "male",
      firstName: "abdo",
      lastName: "abdoa",
      email: "abdo@d.com",
      password: "dd",
      rePassword: "dd",
      phone: "12345",
    );
    user = UserDto(
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
    dummySignupResponse = SignupResponse(
      message: "message",
      userDto: user,
      token: "token",
    );
  });
  test('when call signUp it should return Success', () async {
    provideDummy<Result<UserDto>>(Success<UserDto>(user));

    when(
      mockApiClient.signUp(userRequest),
    ).thenAnswer((_) async => dummySignupResponse);
    final result = await datasource.signUp(userRequest);
    expect(result, isA<Success<UserDto>>());
    expect(result as Success<UserDto>, isNotNull);
    expect(result.data.id, equals(user.id));
    expect(result.data.firstName, equals(user.firstName));
    expect(result.data.lastName, equals(user.lastName));
    expect(result.data.email, equals(user.email));
    expect(result.data.phone, equals(user.phone));
    expect(result.data.role, equals(user.role));
    expect(result.data.createdAt, equals(user.createdAt));
    expect(result.data.gender, equals(user.gender));
    expect(result.data.addresses, equals(user.addresses));
    expect(result.data.photo, equals(user.photo));
    expect(result.data.wishlist?.length, equals(user.wishlist?.length));

    verify(mockApiClient.signUp(userRequest)).called(1);
  });
  test('when call signUp it should return Failure', () async {
    String e = 'Exception';
    provideDummy<Result<UserDto>>(Failure<UserDto>(e.toString()));

    when(mockApiClient.signUp(userRequest)).thenThrow(e);
    final result = await datasource.signUp(userRequest);
    expect(result, isA<Failure<UserDto>>());
    expect(result as Failure<UserDto>, isNotNull);
    expect(result.errorMessage, equals(e));
    verify(mockApiClient.signUp(userRequest)).called(1);
  });
}
