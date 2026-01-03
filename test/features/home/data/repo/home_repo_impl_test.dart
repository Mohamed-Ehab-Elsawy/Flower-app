import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/error_handling/failures.dart';
import 'package:flower_app/core/error_handling/handle_exception%20.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:flower_app/features/home/data/models/best_seller_response.dart';
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
  late HomeDataSource dataSource;
  late HomeRepo repo;
  late List<ProductsDto> productsDtoList;
  late List<ProductsEntity> productsEntityList;
  late String? categoryId;
  late String? occasionId;
  late Exception exception;

  setUp(() {
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
        images: const ["httpng", "httpsg"],
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
        images: const ["httpng", "httpsg"],
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

  group('test home repo impl', () {
    final tBestSellerResponse = BestSellerResponse();
    test('when getBestSeller is called then return Success', () async {
      // arrange
      provideDummy<Result<BestSellerResponse>>(Success(BestSellerResponse()));

      when(
        dataSource.getBestSeller(),
      ).thenAnswer((_) async => Success(tBestSellerResponse));
      // act
      final result = await repo.getBestSeller();
      // assert
      expect(result, isA<Success<List<ProductsEntity>>>());

      verify(dataSource.getBestSeller()).called(1);
    });

    test('when getBestSeller is called then return failure', () async {
      // arrange
      const appFailure = UnexpectedFailure("error");
      final failureResponse = Failure<BestSellerResponse>(appFailure.message!);
      provideDummy<Result<BestSellerResponse>>(
        Failure(failureResponse.errorMessage),
      );

      when(
        dataSource.getBestSeller(),
      ).thenAnswer((_) async => (failureResponse));
      // act
      final result = await repo.getBestSeller();
      // assert
      expect(result, isA<Failure<List<ProductsEntity>>>());

      verify(dataSource.getBestSeller()).called(1);
    });
  });

  group("TEST repo FetchData", () {
    test("FetchData should return HomeResponseDto when Pass", () async {
      //arrange
      final tHomeResponseDto = Success<HomeResponseDto>(
        HomeResponseDto(message: "success"),
      );
      final tHomeResponseEntity = tHomeResponseDto.data.toEntity();
      provideDummy<Result<HomeResponseDto>>(tHomeResponseDto);
      when(
        dataSource.fetchHomeData(),
      ).thenAnswer((_) async => tHomeResponseDto);
      //act
      final result = await repo.fetchHomeData() as Success<HomeResponseEntity>;
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
      when(dataSource.fetchHomeData()).thenAnswer((_) async => failureResponse);
      //act
      final result = await repo.fetchHomeData() as Failure<HomeResponseEntity>;
      //assert
      expect(result, isA<Failure<HomeResponseEntity>>());
      expect(result.errorMessage, "UnexpectedFailure");
    });
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
