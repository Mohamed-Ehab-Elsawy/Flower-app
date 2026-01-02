import 'package:flower_app/core/app/data/models/product_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';

abstract interface class HomeDataSource {
  Future<Result<List<ProductDto>>> getProducts({
    String? occasionId,
    String? categoryId,
  });
}
