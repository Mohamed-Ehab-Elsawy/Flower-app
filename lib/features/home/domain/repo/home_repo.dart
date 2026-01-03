import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';

abstract interface class HomeRepo {
  Future<Result<List<ProductsEntity>>> getBestSeller();
  Future<Result<HomeResponseEntity>> fetchHomeData();

  Future<Result<List<ProductsEntity>>> getProducts({
    String? occasionId,
    String? categoryId,
  });
}
