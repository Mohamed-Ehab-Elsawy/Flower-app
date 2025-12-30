import 'package:flower_app/core/error_handling/failures.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:flower_app/features/home/data/models/best_seller_response.dart';
import 'package:flower_app/features/home/data/repo/home_repo_impl.dart';
import 'package:flower_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repo_impl_test.mocks.dart';

@GenerateMocks([HomeDataSource])
void main() {
  late HomeDataSource mockHomeDataSource;
  late HomeRepoImpl homeRepoImpl;

  setUp(() {
    mockHomeDataSource = MockHomeDataSource();
    homeRepoImpl = HomeRepoImpl(mockHomeDataSource);
  });
  group('test home repo impl', () {
    final tBestSellerResponse = BestSellerResponse();
    test('when getBestSeller is called then return Success', () async {
      // arrange
      provideDummy<Result<BestSellerResponse>>(Success(BestSellerResponse()));

      when(
        mockHomeDataSource.getBestSeller(),
      ).thenAnswer((_) async => Success(tBestSellerResponse));
      // act
      final result = await homeRepoImpl.getBestSeller();
      // assert
      expect(result, isA<Success<BestSellerEntity>>());

      verify(mockHomeDataSource.getBestSeller()).called(1);
    });

    test('when getBestSeller is called then return failure', () async {
      // arrange
      const appFailure = UnexpectedFailure("error");
      final failureResponse = Failure<BestSellerResponse>(appFailure.message!);
      provideDummy<Result<BestSellerResponse>>(
        Failure(failureResponse.errorMessage),
      );

      when(
        mockHomeDataSource.getBestSeller(),
      ).thenAnswer((_) async => (failureResponse));
      // act
      final result = await homeRepoImpl.getBestSeller();
      // assert
      expect(result, isA<Failure<BestSellerEntity>>());

      verify(mockHomeDataSource.getBestSeller()).called(1);
    });
  });
}
