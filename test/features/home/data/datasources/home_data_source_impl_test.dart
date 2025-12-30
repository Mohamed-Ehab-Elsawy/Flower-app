import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/failures.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source_impl.dart';
import 'package:flower_app/features/home/data/models/best_seller_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../auth/data/datasources/auth_ds_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late ApiClient mockApiClient;
  late HomeDataSourceImpl homeDataSourceImpl;
  setUp(() {
    mockApiClient = MockApiClient();
    homeDataSourceImpl = HomeDataSourceImpl(mockApiClient);
  });

  group('test home data source impl cases when fetch best seller data', () {
    final tBestSellerResponse = BestSellerResponse();
    test(
      'when getBestSeller is called then return best seller with data',
      () async {
        // arrange
        when(
          mockApiClient.getBestSeller(),
        ).thenAnswer((_) async => tBestSellerResponse);

        // act
        final result = await homeDataSourceImpl.getBestSeller();

        // assert
        expect(result, isA<Success<BestSellerResponse>>());
        expect((result as Success).data, tBestSellerResponse);
        verify(mockApiClient.getBestSeller()).called(1);
      },
    );

    test(
      'when getBestSeller is called then return failure with error message',
      () async {
        // arrange
        AppFailure failure = const UnexpectedFailure('Server Error');
        when(mockApiClient.getBestSeller()).thenThrow((failure));

        // act
        final result = await homeDataSourceImpl.getBestSeller();

        // assert
        expect(result, isA<Failure<BestSellerResponse>>());
        verify(mockApiClient.getBestSeller()).called(1);
      },
    );
  });
}
