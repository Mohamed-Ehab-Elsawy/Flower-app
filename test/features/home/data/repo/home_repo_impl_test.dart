import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/error_handling/handle_exception%20.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:flower_app/features/home/data/repo/home_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repo_impl_test.mocks.dart' show MockHomeDataSource;

@GenerateMocks([HomeDataSource])
void main() {
  late MockHomeDataSource dataSource;
  late HomeRepoImpl repo;
  late List<ProductsDto> productsDtoList;
  late List<ProductsEntity> productsEntityList;
  late String? categoryId;
  late String? occasionId;
  late Exception exception;
  setUpAll(() {
    dataSource = MockHomeDataSource();
    repo = HomeRepoImpl(dataSource);
    productsDtoList = [
      const ProductsDto(id: '1', title: 'title', description: 'description'),
      const ProductsDto(id: '2', title: 'title', description: 'description'),
    ];
    productsEntityList = [
      ProductsEntity(
        id: '1',
        title: 'title',
        description: 'description',
        imageCover: 'imageCover',
        price: 10.0,
        priceAfterDiscount: 5.0,
        quantity: 10,
        categoryId: 'categoryId',
        occasionId: 'occasionId',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSuperAdmin: true,
        sold: 10,
        slug: '',
        ratingAverage: null,
        ratingCount: null,
        images: ["httpng", "httpsg"],
      ),
      ProductsEntity(
        id: '1',
        title: 'title',
        description: 'description',
        imageCover: 'imageCover',
        price: 10.0,
        priceAfterDiscount: 5.0,
        quantity: 10,
        categoryId: 'categoryId',
        occasionId: 'occasionId',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSuperAdmin: true,
        sold: 10,
        slug: '',
        ratingAverage: null,
        ratingCount: null,
        images: ["httpng", "httpsg"],
      ),
    ];
    exception = Exception("error");
    provideDummy<Result<List<ProductsDto>>>(
      Success<List<ProductsDto>>(productsDtoList),
    );
    provideDummy<Result<List<ProductsEntity>>>(
      Success<List<ProductsEntity>>(productsEntityList),
    );
    categoryId = "category_1";
    occasionId = "occasion_1";
  });
  group("when call getProducts with no parameters ", () {
    test(
      'Testing getProducts with no parameter it should return Success with productsDto ',
      () async {
        when(
          dataSource.getProducts(occasionId: null, categoryId: null),
        ).thenAnswer((_) async => Success<List<ProductsDto>>(productsDtoList));
        final result = await repo.getProducts();
        expect(result, isA<Success<List<ProductsEntity>>>());
        expect(result as Success<List<ProductsEntity>>, isNotNull);
        expect(result.data.length, equals(2));
        verify(
          dataSource.getProducts(occasionId: null, categoryId: null),
        ).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );
    test(
      'Testing getProducts with no parameter it should return Failure with error message ',
      () async {
        when(
          dataSource.getProducts(occasionId: null, categoryId: null),
        ).thenAnswer(
          (_) async => Failure<List<ProductsDto>>(
            NetworkException.getMessageError(exception),
          ),
        );
        final result = await repo.getProducts(
          categoryId: null,
          occasionId: null,
        );
        expect(result, isA<Failure<List<ProductsEntity>>>());
        expect(result as Failure<List<ProductsEntity>>, isNotNull);
        expect(
          result.errorMessage,
          equals(NetworkException.getMessageError(exception)),
        );
        verify(
          dataSource.getProducts(occasionId: null, categoryId: null),
        ).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );
  });
  group("when call getProducts with occasionId parameter ", () {
    test(
      'Testing getProducts with occasionId parameter it should return Success with productsDto(occasion) ',
      () async {
        when(
          dataSource.getProducts(occasionId: occasionId, categoryId: null),
        ).thenAnswer((_) async => Success<List<ProductsDto>>(productsDtoList));
        final result = await repo.getProducts(
          occasionId: occasionId,
          categoryId: null,
        );
        expect(result, isA<Success<List<ProductsEntity>>>());
        expect(result as Success<List<ProductsEntity>>, isNotNull);
        expect(result.data.length, equals(2));
        verify(
          dataSource.getProducts(occasionId: occasionId, categoryId: null),
        ).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );
    test(
      'Testing getProducts with occasionId parameter it should return Failure with error message ',
      () async {
        when(
          dataSource.getProducts(occasionId: occasionId, categoryId: null),
        ).thenAnswer(
          (_) async => Failure<List<ProductsDto>>(
            NetworkException.getMessageError(exception),
          ),
        );
        final result = await repo.getProducts(
          occasionId: occasionId,
          categoryId: null,
        );
        expect(result, isA<Failure<List<ProductsEntity>>>());
        expect(result as Failure<List<ProductsEntity>>, isNotNull);
        expect(
          result.errorMessage,
          equals(NetworkException.getMessageError(exception)),
        );
        verify(
          dataSource.getProducts(occasionId: occasionId, categoryId: null),
        ).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );
  });
  group("when call getProducts with categoryId parameter ", () {
    test(
      'Testing getProducts with categoryId parameter it should return Success with productsDto(category) ',
      () async {
        when(
          dataSource.getProducts(occasionId: null, categoryId: categoryId),
        ).thenAnswer((_) async => Success<List<ProductsDto>>(productsDtoList));
        final result = await repo.getProducts(
          occasionId: null,
          categoryId: categoryId,
        );
        expect(result, isA<Success<List<ProductsEntity>>>());
        expect(result as Success<List<ProductsEntity>>, isNotNull);
        expect(result.data.length, equals(2));
        verify(
          dataSource.getProducts(occasionId: null, categoryId: categoryId),
        ).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );
    test(
      'Testing getProducts with categoryId parameter it should return Failure with error message ',
      () async {
        when(
          dataSource.getProducts(occasionId: null, categoryId: categoryId),
        ).thenAnswer(
          (_) async => Failure<List<ProductsDto>>(
            NetworkException.getMessageError(exception),
          ),
        );
        final result = await repo.getProducts(
          occasionId: null,
          categoryId: categoryId,
        );
        expect(result, isA<Failure<List<ProductsEntity>>>());
        expect(result as Failure<List<ProductsEntity>>, isNotNull);
        expect(
          result.errorMessage,
          equals(NetworkException.getMessageError(exception)),
        );
        verify(
          dataSource.getProducts(occasionId: null, categoryId: categoryId),
        ).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );
  });
}
