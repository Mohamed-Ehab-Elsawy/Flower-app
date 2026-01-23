import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/error_handling/result.dart';
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
    const productsList = [ProductsEntity(id: '1'), ProductsEntity(id: '2')];
    const tErrorMessage = 'Network error';
    test(
      'when call getBestSeller use case then return success result ',
      () async {
        // arrange
        provideDummy<Result<List<ProductsEntity>>>(Success(productsList));
        final tResponse = Success<List<ProductsEntity>>(productsList);
        when(mockHomeRepo.getBestSeller()).thenAnswer((_) async => tResponse);
        // act
        final result = await getBestSellerUseCase.invoke();
        // assert
        expect(result, tResponse);
        expect((result as Success<List<ProductsEntity>>).data, productsList);
        expect((result).data, hasLength(2));
      },
    );
    test(
      'when call getBestSeller use case then return failure result ',
      () async {
        // arrange
        provideDummy<Result<List<ProductsEntity>>>(Failure(tErrorMessage));
        final tResponse = Failure<List<ProductsEntity>>("error");
        when(mockHomeRepo.getBestSeller()).thenAnswer((_) async => tResponse);
        // act
        final result = await getBestSellerUseCase.invoke();
        // assert
        expect(result, tResponse);
      },
    );
  });
}
