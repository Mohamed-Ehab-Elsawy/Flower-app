import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/error_handling/result.dart';

abstract interface class CategoryRepo {
  Future<Result<List<ProductTypeEntity>>> getCategories();
}
