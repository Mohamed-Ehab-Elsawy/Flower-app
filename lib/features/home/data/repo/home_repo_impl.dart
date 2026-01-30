import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:flower_app/features/home/data/models/best_seller_response.dart';
import 'package:flower_app/core/app/data/mapper/product_mapper.dart';
import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/mapper/best_seller_mapper.dart';
import 'package:flower_app/features/home/domain/repo/home_repo.dart';
import 'package:flower_app/features/home/mapper/home_response_mapper.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeDataSource _homeDataSource;

  const HomeRepoImpl(this._homeDataSource);

  @override
  Future<Result<HomeResponseEntity>> fetchHomeData() async {
    var response = await _homeDataSource.fetchHomeData();
    switch (response) {
      case Success<HomeResponseDto>():
        var result = response.data.toEntity();
        return Success(result);
      case Failure<HomeResponseDto>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<List<ProductsEntity>>> getBestSeller() async {
    final response = await _homeDataSource.getBestSeller();
    switch (response) {
      case Success<BestSellerResponse>():
        final items = response.data.bestSeller ?? [];
        final products = items.map((dto) => dto.toProductsEntity()).toList();

        return Success(products);
      case Failure<BestSellerResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<List<ProductsEntity>>> getProducts({
    String? occasionId,
    String? categoryId,
    String? keyword,
    String? sort,
  }) async {
    Result<List<ProductsDto>> productResponse = await _homeDataSource
        .getProducts(
          occasionId: occasionId,
          categoryId: categoryId,
          keyword: keyword,
        );
        .getProducts(
          occasionId: occasionId,
          categoryId: categoryId,
          sort: sort,
        );

    switch (productResponse) {
      case Success<List<ProductsDto>>():
        {
          List<ProductsDto> productsDto = productResponse.data;
          List<ProductsEntity> productsEntity = productsDto
              .map((dto) => dto.toEntity())
              .toList();
          return Success<List<ProductsEntity>>(productsEntity);
        }

      case Failure<List<ProductsDto>>():
        {
          return Failure<List<ProductsEntity>>(productResponse.errorMessage);
        }
    }
  }
}
