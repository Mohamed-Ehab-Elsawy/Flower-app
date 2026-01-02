import 'package:flower_app/core/app/data/models/product_type_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';

abstract interface class CategoryDataSource {
  Future<Result<List<ProductTypeDto>>> getCategories();
}
