import 'package:flower_app/features/profile/domain/usecases/edit_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repo.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late EditProfileRequest editProfileRequest;
  late UserEntity userEntity;
  late Success<UserEntity> successResponse;
  late Failure<UserEntity> failureResponse;
  late MockProfileRepo mockProfileRepo;
  late EditProfileUseCase editProfileUseCase;

  setUp(() {
    editProfileRequest = const EditProfileRequest(
      firstName: "Mohamed",
      lastName: "Kamal",
      email: "updated@test.com",
      phone: "01111111111",
    );
    userEntity = UserEntity(
      id: "1",
      firstName: "Mohamed",
      lastName: "Kamal",
      email: "updated@test.com",
      phone: "01111111111",
    );
    successResponse = Success<UserEntity>(userEntity);
    failureResponse = Failure<UserEntity>("Failed to edit profile");
    mockProfileRepo = MockProfileRepo();
    editProfileUseCase = EditProfileUseCase(mockProfileRepo);
  });

  test(
    'should return Success with updated UserEntity when editProfile succeeds',
    () async {
      // Arrange
      provideDummy<Result<UserEntity>>(successResponse);
      when(
        mockProfileRepo.editProfile(editProfileRequest: editProfileRequest),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await editProfileUseCase.call(
        editProfileRequest: editProfileRequest,
      );

      // Assertion And Verifications
      expect(result, isA<Success<UserEntity>>());
      expect(
        (result as Success<UserEntity>).data.firstName,
        equals(userEntity.firstName),
      );
      expect(result.data.email, equals(userEntity.email));
      verify(
        mockProfileRepo.editProfile(editProfileRequest: editProfileRequest),
      ).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    },
  );

  test('should return Failure when editProfile fails', () async {
    // Arrange
    provideDummy<Result<UserEntity>>(failureResponse);
    when(
      mockProfileRepo.editProfile(editProfileRequest: editProfileRequest),
    ).thenAnswer((_) async => failureResponse);

    // Act
    final result = await editProfileUseCase.call(
      editProfileRequest: editProfileRequest,
    );

    // Assertion And Verifications
    expect(result, isA<Failure<UserEntity>>());
    expect(
      (result as Failure<UserEntity>).errorMessage,
      equals("Failed to edit profile"),
    );
    verify(
      mockProfileRepo.editProfile(editProfileRequest: editProfileRequest),
    ).called(1);
    verifyNoMoreInteractions(mockProfileRepo);
  });
}
