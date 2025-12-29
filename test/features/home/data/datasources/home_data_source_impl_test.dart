import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/failures.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source_impl.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late ApiClient apiClient;
  late HomeDataSource homeDataSourceImpl;
  setUp(() {
    apiClient = MockApiClient();
    homeDataSourceImpl = HomeDataSourceImpl(apiClient);
  });
  group("TEST HomeDataSourceImpl  FetchData", () {
    test("FetchData should return HomeResponseDto when Pass", () async {
      //arrange
      final tHomeResponseDto = HomeResponseDto(message: "success");

      when(apiClient.fetchHomeData()).thenAnswer((_) async => tHomeResponseDto);
      //act
      final result = await homeDataSourceImpl.fetchHomeData();
      //assert
      expect(result, isA<Success<HomeResponseDto>>());
    });
    test("FetchData should return Failure when Exception", () async {
      //arrange
      AppFailure appFailure = const UnexpectedFailure("UnexpectedFailure");

      when(apiClient.fetchHomeData()).thenThrow(appFailure);
      //act
      final result = await homeDataSourceImpl.fetchHomeData();
      //assert
      expect(result, isA<Failure<HomeResponseDto>>());
    });
  });
}
