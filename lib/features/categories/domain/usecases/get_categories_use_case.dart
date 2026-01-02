import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/categories/domain/repo/category_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  final CategoryRepo _categoryRepo;

  GetCategoriesUseCase(this._categoryRepo);

  Future<Result<List<ProductTypeEntity>>> call() =>
      _categoryRepo.getCategories();
}
