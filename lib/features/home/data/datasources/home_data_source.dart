import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/models/best_seller_response.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';

abstract interface class HomeDataSource {
  Future<Result<List<ProductsDto>>> getProducts({
    String? occasionId,
    String? categoryId,
    String? sort,
  });
  Future<Result<HomeResponseDto>> fetchHomeData();
  Future<Result<BestSellerResponse>> getBestSeller();
}
