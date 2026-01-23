import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:flower_app/features/profile/domain/usecases/get_profile_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_profile_data_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late UserEntity userEntity;
  late Success<UserEntity> successResponse;
  late Failure<UserEntity> failureResponse;
  late MockProfileRepo mockProfileRepo;
  late GetProfileDataUseCase getProfileDataUseCase;

  setUp(() {
    userEntity = UserEntity(
      id: "1",
      firstName: "Test User",
      email: "test@test.com",
      phone: "01234567890",
    );
    successResponse = Success<UserEntity>(userEntity);
    failureResponse = Failure<UserEntity>("Failed to get profile data");
    mockProfileRepo = MockProfileRepo();
    getProfileDataUseCase = GetProfileDataUseCase(mockProfileRepo);
  });

  test(
    'should return Success with UserEntity when getProfileData succeeds',
    () async {
      // Arrange
      provideDummy<Result<UserEntity>>(successResponse);
      when(
        mockProfileRepo.getProfileData(),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await getProfileDataUseCase.call();

      // Assertion And Verifications
      expect(result, isA<Success<UserEntity>>());
      expect((result as Success<UserEntity>).data.id, equals(userEntity.id));
      expect(result.data.firstName, equals(userEntity.firstName));
      verify(mockProfileRepo.getProfileData()).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    },
  );

  test('should return Failure when getProfileData fails', () async {
    // Arrange
    provideDummy<Result<UserEntity>>(failureResponse);
    when(
      mockProfileRepo.getProfileData(),
    ).thenAnswer((_) async => failureResponse);

    // Act
    final result = await getProfileDataUseCase.call();

    // Assertion And Verifications
    expect(result, isA<Failure<UserEntity>>());
    expect(
      (result as Failure<UserEntity>).errorMessage,
      equals("Failed to get profile data"),
    );
    verify(mockProfileRepo.getProfileData()).called(1);
    verifyNoMoreInteractions(mockProfileRepo);
  });
}
