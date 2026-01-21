import 'package:flower_app/core/app/data/mapper/product_type_mapper.dart';
import 'package:flower_app/core/app/data/models/product_type_dto.dart';
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
  Future<Result<List<ProductTypeEntity>>> getCategories() async {
    var result = await _categoryDataSource.getCategories();
    switch (result) {
      case Success<List<ProductTypeDto>>():
        return Success(result.data.map((e) => e.toEntity()).toList());
      case Failure<List<ProductTypeDto>>():
        return Failure(result.errorMessage);
    }
  }
}
