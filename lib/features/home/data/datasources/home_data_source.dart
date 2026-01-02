import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';

abstract interface class HomeDataSource {
  Future<Result<List<ProductsDto>>> getProducts({
    String? occasionId,
    String? categoryId,
  });
}
