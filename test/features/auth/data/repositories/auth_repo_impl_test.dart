import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthDataSource])
void main() {
  late MockAuthDataSource mockAuthDataSource;
  late AuthRepoImpl authRepo;
  late LoginRequest loginRequest;
  late LoginResponseDto loginResponse;
  late Result<LoginResponseDto> response;
  late AuthRepoImpl mockRepo;
  late UserSignupRequest userRequest;
  late UserDto userDto;
  late UserEntity userEntity;
  late String message;
  setUp(() {
    // Arrange:
    mockAuthDataSource = MockAuthDataSource();
    authRepo = AuthRepoImpl(mockAuthDataSource);

    loginRequest =  const LoginRequest(email: "test@test.com", password: "123456");
    loginResponse = LoginResponseDto(
      userDto: UserDto(id: "1"),
      token: "abc123",
      message: "success",
    );
    response = Success(loginResponse);

    provideDummy<Result<LoginResponseDto>>(response);

    when(
      mockAuthDataSource.login(loginRequest: loginRequest),
    ).thenAnswer((_) async => response);
    message = "error message";
    userRequest = UserSignupRequest(
      gender: "male",
      firstName: "abdo",
      lastName: "abdoa",
      email: "abdo@d.com",
      password: "dd",
      rePassword: "dd",
      phone: "12345",
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
    userEntity = UserEntity(
      id: "d",
      firstName: "abdo",
      lastName: "abdoa",
      email: "",
      phone: "12345",
      role: "role",
      addresses: [12, 45],
      gender: "male",
      photo: "ddd",
    );
    mockAuthDataSource = MockAuthDataSource();
    mockRepo = AuthRepoImpl(mockAuthDataSource);

    provideDummy<Result<UserDto>>(Success<UserDto>(userDto));
    provideDummy<Result<UserEntity>>(Success<UserEntity>(userEntity));

  });
  test("should call get login response from data source with correct params",() {
    // Act
    authRepo.login(loginRequest: loginRequest);

    // Assert
    verify(mockAuthDataSource.login(loginRequest: loginRequest)).called(1);
    verifyNoMoreInteractions(mockAuthDataSource);
  },
  );
  test("when signUp with Success it should return UserEntity", () async {
    when(
      mockAuthDataSource.signUp(userRequest),
    ).thenAnswer((_) async => Success<UserDto>(userDto));
    final result = await mockRepo.signUp(userRequest);

    expect(result, isA<Success<UserEntity>>());
    expect(
      (result as Success<UserEntity>).data.firstName,
      equals(userEntity.firstName),
    );
    expect(result.data.lastName, equals(userEntity.lastName));
    expect(result.data.email, equals(userEntity.email));
    expect(result.data.photo, equals(userEntity.photo));
    expect(result.data.phone, equals(userEntity.phone));
    expect(result.data.addresses?.length, equals(userEntity.addresses?.length));
    expect(result.data.id, equals(userEntity.id));
    expect(result.data.gender, equals(userEntity.gender));
    expect(result.data.role, equals(userEntity.role));
    verify(mockRepo.signUp(userRequest)).called(1);
  });

  test("when signUp with Failure it should return message", () async {
    when(
      mockAuthDataSource.signUp(userRequest),
    ).thenAnswer((_) async => Failure<UserDto>(message));
    final result = await mockRepo.signUp(userRequest);

    expect(result, isA<Failure<UserEntity>>());
    expect(
      (result as Failure<UserEntity>).errorMessage.toString(),
      equals(message),
    );
    verify(mockRepo.signUp(userRequest)).called(1);
  });
}
