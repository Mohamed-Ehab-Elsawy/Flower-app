import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/error_handling/result.dart';

abstract interface class HomeRepo {
  Future<Result<List<ProductsEntity>>> getProducts({
    String? occasionId,
    String? categoryId,
  });
}
