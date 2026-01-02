import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:flower_app/features/home/data/models/best_seller_response.dart';
import 'package:flower_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:flower_app/features/home/domain/mapper/best_seller_response_mapper.dart';
import 'package:flower_app/core/app/data/mapper/product_mapper.dart';
import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:flower_app/features/home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  HomeDataSource dataSource;

  HomeRepoImpl(this.dataSource);
  @override
  Future<Result<BestSellerEntity>> getBestSeller() async {
    final response = await dataSource.getBestSeller();
    switch (response) {
      case Success<BestSellerResponse>():
        var result = response.data.toModel();
        return Success(result);
        case Failure<BestSellerResponse>():
        return Failure(response.errorMessage);
    }
  }
  @override
  Future<Result<List<ProductsEntity>>> getProducts({
    String? occasionId,
    String? categoryId,
  }) async {
    Result<List<ProductsDto>> productResponse = await dataSource.getProducts(
      occasionId: occasionId,
      categoryId: categoryId,
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
