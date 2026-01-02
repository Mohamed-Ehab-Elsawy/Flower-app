import 'package:flower_app/core/app/data/mapper/product_mapper.dart';
import 'package:flower_app/core/app/data/models/product_dto.dart';
import 'package:flower_app/core/app/domain/entities/product_entity.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:flower_app/features/home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  HomeDataSource dataSource;

  HomeRepoImpl(this.dataSource);
  @override
  Future<Result<List<ProductEntity>>> getProducts({
    String? occasionId,
    String? categoryId,
  }) async {
    Result<List<ProductDto>> productResponse = await dataSource.getProducts(
      occasionId: occasionId,
      categoryId: categoryId,
    );
    switch (productResponse) {
      case Success<List<ProductDto>>():
        {
          List<ProductDto> productsDto = productResponse.data;
          List<ProductEntity> productsEntity = productsDto
              .map((dto) => dto.toEntity())
              .toList();
          return Success<List<ProductEntity>>(productsEntity);
        }

      case Failure<List<ProductDto>>():
        {
          return Failure<List<ProductEntity>>(productResponse.errorMessage);
        }
    }
  }
}
