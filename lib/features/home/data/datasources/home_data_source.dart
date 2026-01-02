import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';

abstract interface class HomeDataSource {
  Future<Result<List<ProductsDto>>> getProducts({
    String? occasionId,
    String? categoryId,
  });
}
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';

abstract interface class HomeDataSource {
   Future<Result<HomeResponseDto>> fetchHomeData();
}
