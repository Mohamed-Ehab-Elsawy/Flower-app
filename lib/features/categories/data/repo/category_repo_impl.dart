import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/categories/data/datasources/category_data_source.dart';
import 'package:flower_app/features/categories/domain/repo/category_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoryRepo)
class CategoryRepoImpl implements CategoryRepo {
  final CategoryDataSource _categoryDataSource;

  CategoryRepoImpl(this._categoryDataSource);

  @override
  Future<Result<List<ProductTypeEntity>>> getCategories() =>
      _categoryDataSource.getCategories();
}
