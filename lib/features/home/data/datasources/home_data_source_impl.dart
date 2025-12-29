import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/home/data/datasources/home_data_source.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {
  final ApiClient _apiClient;
  const HomeDataSourceImpl(this._apiClient);
  @override
  Future<Result<HomeResponseDto>> fetchHomeData() {
    return executeApi(() async => await _apiClient.fetchHomeData());
  }
}