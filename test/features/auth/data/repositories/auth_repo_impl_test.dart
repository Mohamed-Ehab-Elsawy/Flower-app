import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthDataSource])
void main() {
  late AuthRepoImpl mockRepo;
  late UserRequest userRequest;
  late UserDto userDto;
  late UserEntity userEntity;
  late MockAuthDataSource mockAuthDataSource;
  late String message;
  setUpAll(() {
    message = "error message";
    userRequest = UserRequest(
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
