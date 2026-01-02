import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:flower_app/features/home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBestSellerUseCase {
  final HomeRepo _homeRepo;

  GetBestSellerUseCase(this._homeRepo);
  Future<Result<BestSellerEntity>> invoke() => _homeRepo.getBestSeller();
}
