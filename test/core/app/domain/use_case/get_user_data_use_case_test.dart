import 'package:flower_app/core/app/data/repositories/app_sections_repo_impl.dart';
import 'package:flower_app/core/app/domain/repositories/app_sections_repo.dart';
import 'package:flower_app/core/app/domain/use_case/get_user_data_use_case.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart'
    show UserEntity;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_data_use_case_test.mocks.dart';

@GenerateMocks([AppSectionsRepoImpl])
void main() {
  late AppSectionsRepo mockAppSectionsRepo;
  late GetUserDataUseCase getUserDataUseCase;
  late UserEntity userEntity;
  setUp(() {
    mockAppSectionsRepo = MockAppSectionsRepoImpl();
    getUserDataUseCase = GetUserDataUseCase(mockAppSectionsRepo);
    userEntity = UserEntity(
      id: '1',
      firstName: 'Mohamed',
      lastName: 'Ehab',
      email: 'john.mclean@examplepetstore.com',
    );
  });

  test(
    "when i call getUserDataUseCase it should call getUserData in repo",
    () async {
      // arrange
      var successResponse = Success(userEntity);
      provideDummy<Result<UserEntity>>(successResponse);
      when(
        mockAppSectionsRepo.getUserData(),
      ).thenAnswer((_) async => successResponse);
      // act
      await getUserDataUseCase.call();
      // assert
      verify(mockAppSectionsRepo.getUserData()).called(1);
      verifyNoMoreInteractions(mockAppSectionsRepo);
    },
  );
}
