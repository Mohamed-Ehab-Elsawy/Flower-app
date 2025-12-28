import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/models_dto/product_dto.dart';

abstract interface class HomeDataSource {
  Future<Result<List<ProductsDto>>> getProducts({
    String? occasionId,
    String? categoryId,
  });
}
