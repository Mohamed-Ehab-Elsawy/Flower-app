import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/app/data/models/product_response.dart';
import 'package:flower_app/core/app/data/models/products_dto.dart'
    show ProductsDto;
import 'package:flower_app/core/error_handling/failures.dart';
import 'package:flower_app/core/error_handling/handle_exception%20.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source_impl.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late HomeDataSourceImpl homeDataSourceImpl;
  late MockApiClient api;
  late ProductResponse productResponse;
  late List<ProductsDto> productsDtoList;
  late String? categoryId;
  late String? occasionId;
  late Exception exception;

  setUpAll(() {
    api = MockApiClient();
    homeDataSourceImpl = HomeDataSourceImpl(api);
    productsDtoList = [
      const ProductsDto(id: '1', title: 'title', description: 'description'),
      const ProductsDto(id: '2', title: 'title', description: 'description'),
    ];
    productResponse = ProductResponse(
      message: "message",
      productsDto: productsDtoList,
    );
    exception = Exception("error");
    occasionId = "occasion_1";
    categoryId = "category_1";
  });

 group("TEST HomeDataSourceImpl  FetchData", () {
    test("FetchData should return HomeResponseDto when Pass", () async {
      //arrange
      final tHomeResponseDto = HomeResponseDto(message: "success");

      when(api.fetchHomeData()).thenAnswer((_) async => tHomeResponseDto);
      //act
      final result = await homeDataSourceImpl.fetchHomeData();
      //assert
      expect(result, isA<Success<HomeResponseDto>>());
    });
    test("FetchData should return Failure when Exception", () async {
      //arrange
      AppFailure appFailure = const UnexpectedFailure("UnexpectedFailure");

      when(api.fetchHomeData()).thenThrow(appFailure);
      //act
      final result = await homeDataSourceImpl.fetchHomeData();
      //assert
      expect(result, isA<Failure<HomeResponseDto>>());
    });
  });


  group("when call getProducts with no parameters", () {
    test(
      'when call getProducts with no parameters it should return Success with productsDto ',
      () async {
        when(api.getProducts()).thenAnswer((_) async => productResponse);
        final result = await homeDataSourceImpl.getProducts();
        expect(result, isA<Success<List<ProductsDto>>>());
        expect(result as Success<List<ProductsDto>>, isNotNull);
        expect(result.data.length, equals(2));
        for (var i = 0; i < result.data.length; i++) {
          expect(result.data[i].id, equals(productsDtoList[i].id));
          expect(
            result.data[i].description,
            equals(productsDtoList[i].description),
          );
          expect(result.data[i].title, equals(productsDtoList[i].title));
        }

        verify(api.getProducts()).called(1);
        verifyNoMoreInteractions(api);
      },
    );
    test(
      'when call getProducts with no parameters it should return Failure with error message ',
      () async {
        when(api.getProducts()).thenThrow(exception);
        final result = await homeDataSourceImpl.getProducts();
        expect(result, isA<Failure<List<ProductsDto>>>());
        expect(result as Failure<List<ProductsDto>>, isNotNull);
        expect(
          result.errorMessage,
          equals(NetworkException.getMessageError(exception)),
        );
        verify(api.getProducts()).called(1);
        verifyNoMoreInteractions(api);
      },
    );
  });
  group("when call getProducts with categoryId parameters", () {
    test(
      'when call getProducts with categoryId parameter it should return Success with productsDto(category) ',
      () async {
        when(
          api.getProducts(categoryId: categoryId, occasionId: null),
        ).thenAnswer((_) async => productResponse);
        final result = await homeDataSourceImpl.getProducts(
          categoryId: categoryId,
          occasionId: null,
        );
        expect(result, isA<Success<List<ProductsDto>>>());
        expect(result as Success<List<ProductsDto>>, isNotNull);
        expect(result.data.length, equals(2));
        for (var i = 0; i < result.data.length; i++) {
          expect(result.data[i].id, equals(productsDtoList[i].id));
          expect(
            result.data[i].description,
            equals(productsDtoList[i].description),
          );
          expect(result.data[i].title, equals(productsDtoList[i].title));
        }

        verify(
          api.getProducts(categoryId: categoryId, occasionId: null),
        ).called(1);
        verifyNoMoreInteractions(api);
      },
    );
    test(
      'when call getProducts with categoryId parameter it should return Failure with error message ',
      () async {
        when(
          api.getProducts(categoryId: categoryId, occasionId: null),
        ).thenThrow(exception);
        final result = await homeDataSourceImpl.getProducts(
          categoryId: categoryId,
          occasionId: null,
        );
        expect(result, isA<Failure<List<ProductsDto>>>());
        expect(result as Failure<List<ProductsDto>>, isNotNull);
        expect(
          result.errorMessage,
          equals(NetworkException.getMessageError(exception)),
        );
        verify(
          api.getProducts(categoryId: categoryId, occasionId: null),
        ).called(1);
        verifyNoMoreInteractions(api);
      },
    );
  });
  group("when call getProducts with occasionId parameters", () {
    test(
      'when call getProducts with occasionId parameter it should return Success with productsDto(occasion) ',
      () async {
        when(
          api.getProducts(categoryId: null, occasionId: occasionId),
        ).thenAnswer((_) async => productResponse);
        final result = await homeDataSourceImpl.getProducts(
          categoryId: null,
          occasionId: occasionId,
        );
        expect(result, isA<Success<List<ProductsDto>>>());
        expect(result as Success<List<ProductsDto>>, isNotNull);
        expect(result.data.length, equals(2));
        for (var i = 0; i < result.data.length; i++) {
          expect(result.data[i].id, equals(productsDtoList[i].id));
          expect(
            result.data[i].description,
            equals(productsDtoList[i].description),
          );
          expect(result.data[i].title, equals(productsDtoList[i].title));
        }

        verify(
          api.getProducts(categoryId: null, occasionId: occasionId),
        ).called(1);
        verifyNoMoreInteractions(api);
      },
    );
    test(
      'when call getProducts with occasionId parameter it should return Failure with error message ',
      () async {
        when(
          api.getProducts(categoryId: null, occasionId: occasionId),
        ).thenThrow(exception);
        final result = await homeDataSourceImpl.getProducts(
          categoryId: null,
          occasionId: occasionId,
        );
        expect(result, isA<Failure<List<ProductsDto>>>());
        expect(result as Failure<List<ProductsDto>>, isNotNull);
        expect(
          result.errorMessage,
          equals(NetworkException.getMessageError(exception)),
        );
        verify(
          api.getProducts(categoryId: null, occasionId: occasionId),
        ).called(1);
        verifyNoMoreInteractions(api);
      },
    );
  });
}
