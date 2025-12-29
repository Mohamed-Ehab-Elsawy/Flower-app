import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/models/best_seller_response.dart';

abstract interface class HomeDataSource {
  Future<Result<BestSellerResponse>> getBestSeller();
}
