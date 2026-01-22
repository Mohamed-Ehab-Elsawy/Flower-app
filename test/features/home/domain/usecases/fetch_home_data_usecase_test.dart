import 'package:flower_app/core/error_handling/failures.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/repo/home_repo.dart';
import 'package:flower_app/features/home/domain/usecases/fetch_home_data_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_home_data_usecase_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late HomeRepo homeRepo;
  late FetchHomeDataUsecase fetchHomeDataUseCase;
  setUp(() {
    homeRepo = MockHomeRepo();
    fetchHomeDataUseCase = FetchHomeDataUsecase(homeRepo);
  });
  group("TEST HomeUsecase  FetchData", () {
    test("FetchData should return HomeResponseDto when Pass", () async {
      //arrange
      final tHomeResponseEntity = Success<HomeResponseEntity>(
        const HomeResponseEntity(message: "success"),
      );

      provideDummy<Result<HomeResponseEntity>>(tHomeResponseEntity);
      when(
        homeRepo.fetchHomeData(),
      ).thenAnswer((_) async => tHomeResponseEntity);
      //act
      final result =
          await fetchHomeDataUseCase.call() as Success<HomeResponseEntity>;
      //assert
      expect(result, isA<Success<HomeResponseEntity>>());
      expect(result.data.message, "success");
    });
    test("FetchData should return Failure when Exception", () async {
      //arrange
      const appFailure = UnexpectedFailure("UnexpectedFailure");
      final failureResponse = Failure<HomeResponseEntity>(appFailure.message!);
      provideDummy<Result<HomeResponseEntity>>(failureResponse);
      when(homeRepo.fetchHomeData()).thenAnswer((_) async => failureResponse);
      //act
      final result =
          await fetchHomeDataUseCase.call() as Failure<HomeResponseEntity>;
      //assert
      expect(result, isA<Failure<HomeResponseEntity>>());
      expect(result.errorMessage, "UnexpectedFailure");
    });
  });
}
