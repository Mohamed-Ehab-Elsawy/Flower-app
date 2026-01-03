import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBestSellerUseCase {
  final HomeRepo _homeRepo;

  GetBestSellerUseCase(this._homeRepo);
  Future<Result<List<ProductsEntity>>> invoke() => _homeRepo.getBestSeller();
}
