import 'package:flower_app/core/app/domain/entities/product_entity.dart';
import 'package:flower_app/core/error_handling/result.dart';

abstract interface class HomeRepo {
  Future<Result<List<ProductEntity>>> getProducts({
    String? occasionId,
    String? categoryId,
  });
}
