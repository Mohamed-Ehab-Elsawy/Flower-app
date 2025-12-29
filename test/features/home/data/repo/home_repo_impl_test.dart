import 'package:flower_app/core/error_handling/failures.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:flower_app/features/home/data/repo/home_repo_impl.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/repo/home_repo.dart';
import 'package:flower_app/features/home/mapper/home_response_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repo_impl_test.mocks.dart';

@GenerateMocks([HomeDataSource])
void main() {
  late HomeDataSource homeDataSource;
  late HomeRepo homeRepo;
  setUp(() {
    homeDataSource = MockHomeDataSource();
    homeRepo = HomeRepoImpl(homeDataSource);
  });
  group("TEST HomeRepoImpl FetchData", () {
    test("FetchData should return HomeResponseDto when Pass", () async {
      //arrange
      final tHomeResponseDto = Success<HomeResponseDto>(
        HomeResponseDto(message: "success"),
      );
      final tHomeResponseEntity = tHomeResponseDto.data.toEntity();
      provideDummy<Result<HomeResponseDto>>(tHomeResponseDto);
      when(
        homeDataSource.fetchHomeData(),
      ).thenAnswer((_) async => tHomeResponseDto);
      //act
      final result =
          await homeRepo.fetchHomeData() as Success<HomeResponseEntity>;
      //assert
      expect(result, isA<Success<HomeResponseEntity>>());
      expect(result.data, tHomeResponseEntity);
      expect(result.data.message, "success");
    });
    test("FetchData should return Failure when Exception", () async {
      //arrange
      const appFailure = UnexpectedFailure("UnexpectedFailure");
      final failureResponse = Failure<HomeResponseDto>(appFailure.message!);
      provideDummy<Result<HomeResponseDto>>(failureResponse);
      when(homeDataSource.fetchHomeData()).thenAnswer((_) async => failureResponse);
      //act
      final result =
          await homeRepo.fetchHomeData() as Failure<HomeResponseEntity>;
      //assert
      expect(result, isA<Failure<HomeResponseEntity>>());
      expect(result.errorMessage, "UnexpectedFailure");
    });
  });
}
