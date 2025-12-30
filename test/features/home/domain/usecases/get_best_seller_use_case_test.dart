import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:flower_app/features/home/domain/repo/home_repo.dart';
import 'package:flower_app/features/home/domain/usecases/get_best_seller_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_best_seller_use_case_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late HomeRepo mockHomeRepo;
  late GetBestSellerUseCase getBestSellerUseCase;
  setUp(() {
    mockHomeRepo = MockHomeRepo();
    getBestSellerUseCase = GetBestSellerUseCase(mockHomeRepo);
  });
  group('getBestSeller use case test cases', () {
    test(
      'when call getBestSeller use case then return success result ',
      () async {
        // arrange
        provideDummy<Result<BestSellerEntity>>(
          Success(const BestSellerEntity()),
        );
        final tResponse = Success<BestSellerEntity>(const BestSellerEntity());
        when(mockHomeRepo.getBestSeller()).thenAnswer((_) async => tResponse);
        // act
        final result = await getBestSellerUseCase.invoke();
        // assert
        expect(result, tResponse);
      },
    );
    test(
      'when call getBestSeller use case then return failure result ',
      () async {
        // arrange
        provideDummy<Result<BestSellerEntity>>(Failure("error"));
        final tResponse = Failure<BestSellerEntity>("error");
        when(mockHomeRepo.getBestSeller()).thenAnswer((_) async => tResponse);
        // act
        final result = await getBestSellerUseCase.invoke();
        // assert
        expect(result, tResponse);
      },
    );
  });
}
