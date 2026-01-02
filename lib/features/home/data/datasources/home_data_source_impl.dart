import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/app/data/models/product_response.dart';
import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {
  final ApiClient _apiClient;

  HomeDataSourceImpl(this._apiClient);

  @override
  Future<Result<List<ProductsDto>>> getProducts({
    String? occasionId,
    String? categoryId,
  }) {
    return executeApi<List<ProductsDto>>(() async {
      final ProductResponse productResponse = await _apiClient.getProducts(
        occasionId: occasionId,
        categoryId: categoryId,
      );
      List<ProductsDto> productsDto = productResponse.productsDto ?? [];
      return productsDto;
    });
  }
  @override
  Future<Result<BestSellerResponse>> getBestSeller() {
    return executeApi(() async => await _apiClient.getBestSeller());
  }
}
