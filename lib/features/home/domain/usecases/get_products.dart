import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUseCase {
  final HomeRepo repo;

  GetProductsUseCase(this.repo);

  Future<Result<List<ProductsEntity>>> call({
    String? occasionId,
    String? categoryId,
    String? keyword,
  }) {
    return repo.getProducts(
      occasionId: occasionId,
      categoryId: categoryId,
      keyword: keyword,
    );
  }
    String? sort,
  }) => repo.getProducts(
    occasionId: occasionId,
    categoryId: categoryId,
    sort: sort,
  );
}
