import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/app/data/models/product_type_dto.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/categories/data/datasources/category_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoryDataSource)
class CategoryDataSourceImpl implements CategoryDataSource {
  final ApiClient _apiClient;

  CategoryDataSourceImpl(this._apiClient);

  @override
  Future<Result<List<ProductTypeDto>>> getCategories() async =>
      await executeApi(() async {
        final response = await _apiClient.getCategories();
        return response.categories!.toList();
      });
}
