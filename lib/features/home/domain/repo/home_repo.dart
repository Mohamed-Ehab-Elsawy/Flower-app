import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/best_seller_entity.dart';

abstract interface class HomeRepo {
  Future<Result<BestSellerEntity>> getBestSeller();
}
