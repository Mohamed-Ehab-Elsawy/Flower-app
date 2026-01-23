import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/app/data/data_source/app_sections_data_source.dart';
import 'package:flower_app/core/app/data/data_source/app_sections_data_source_impl.dart';
import 'package:flower_app/core/app/data/repositories/app_sections_repo_impl.dart';
import 'package:flower_app/core/app/domain/repositories/app_sections_repo.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_sections_repo_impl_test.mocks.dart';

@GenerateMocks([AppSectionsDataSourceImpl])
void main() {
  late AppSectionsRepo appSectionsRepo;
  late AppSectionsDataSource mockAppSectionsDataSource;
  late UserDto userDto;
  late UserEntity userEntity;
  setUp(() {
    mockAppSectionsDataSource = MockAppSectionsDataSourceImpl();
    appSectionsRepo = AppSectionsRepoImpl(mockAppSectionsDataSource);
    userDto = UserDto(
      id: '1',
      firstName: 'Mohamed',
      lastName: 'Ehab',
      email: 'john.mclean@examplepetstore.com',
    );
    userEntity = UserEntity(
      id: '1',
      firstName: 'Mohamed',
      lastName: 'Ehab',
      email: 'john.mclean@examplepetstore.com',
    );
  });

  test(
    "when i call getCurrentUserData it should return userEntity in success",
    () async {
      var successResponse = Success<UserDto>(userDto);

      provideDummy<Result<UserDto>>(successResponse);
      when(
        mockAppSectionsDataSource.getCurrentUserData(),
      ).thenAnswer((_) async => successResponse);

      var result = await appSectionsRepo.getUserData() as Success<UserEntity>;

      verify(mockAppSectionsDataSource.getCurrentUserData()).called(1);
      verifyNoMoreInteractions(mockAppSectionsDataSource);
      expect(result, isA<Success<UserEntity>>());
      expect(result.data.email, userEntity.email);
    },
  );

  test(
    "when i call getCurrentUserData it should return userEntity in success",
    () async {
      var errorMsg = 'errorMsg';
      var failureResponse = Failure<UserDto>(errorMsg);

      provideDummy<Result<UserDto>>(failureResponse);
      when(
        mockAppSectionsDataSource.getCurrentUserData(),
      ).thenAnswer((_) async => failureResponse);

      var result = await appSectionsRepo.getUserData() as Failure<UserEntity>;

      verify(mockAppSectionsDataSource.getCurrentUserData()).called(1);
      verifyNoMoreInteractions(mockAppSectionsDataSource);
      expect(result, isA<Failure<UserEntity>>());
      expect(result.errorMessage, errorMsg);
    },
  );
}
