import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/domain/entity/about_us_entity.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:flower_app/features/profile/domain/usecases/about_us_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late AboutUsUseCase aboutUsUseCase;
  late MockProfileRepo mockProfileRepo;

  setUp(() {
    mockProfileRepo = MockProfileRepo();
    aboutUsUseCase = AboutUsUseCase(mockProfileRepo);
  });

  group("AboutUsUseCase Test Cases", () {
    const mockEntity = AboutUsEntity(sections: []);
    final successResponse = Success<AboutUsEntity>(mockEntity);
    final failureResponse = Failure<AboutUsEntity>("Error");

    test("should return Success when repository returns success", () async {
      provideDummy<Result<AboutUsEntity>>(successResponse);
      when(
        mockProfileRepo.getAboutUs(),
      ).thenAnswer((_) async => successResponse);

      final result = await aboutUsUseCase.invoke();

      expect(result, isA<Success<AboutUsEntity>>());
      expect((result as Success).data, mockEntity);
      verify(mockProfileRepo.getAboutUs()).called(1);
    });

    test("should return Failure when repository returns failure", () async {
      provideDummy<Result<AboutUsEntity>>(failureResponse);
      when(
        mockProfileRepo.getAboutUs(),
      ).thenAnswer((_) async => failureResponse);

      final result = await aboutUsUseCase.invoke();

      expect(result, isA<Failure<AboutUsEntity>>());
      expect((result as Failure).errorMessage, "Error");
      verify(mockProfileRepo.getAboutUs()).called(1);
    });
  });
}
