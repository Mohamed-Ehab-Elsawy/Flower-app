import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower_app/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_use_case_test.mocks.dart';



@GenerateMocks([AuthRepo])
void main() {
  test('tests calling SignU in use_cases.dart', () async {
    UserEntity userEntity = UserEntity(
      addresses: ["abdo"],
      firstName: "abdo",
      lastName: "abdoa",
      email: "abdo@d.com",
      phone: "12345",
      role: "role",
      gender: "male",
      id: "Id",
      photo: "2024-01-01T00:00:00Z",
    );
    UserRequest userRequest = UserRequest(
      firstName: "abdo",
      lastName: "abdoa",
      email: "abdo@d.com",
      password: "dd",
      rePassword: "dd",
      phone: "12345",
    );
    provideDummy<Result<UserEntity>>(
      Success<UserEntity>(userEntity),
    );
    MockAuthRepo mockRepo = MockAuthRepo();
    SignUpUseCase useCase = SignUpUseCase(mockRepo);

    when(
      mockRepo.signUp(userRequest),
    ).thenAnswer((_) async => Success<UserEntity>(userEntity));
    await useCase.call(userRequest);
    verify(mockRepo.signUp(userRequest));
  });
}
