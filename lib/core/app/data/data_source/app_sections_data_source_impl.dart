import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/app/data/data_source/app_sections_data_source.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AppSectionsDataSource)
class AppSectionsDataSourceImpl implements AppSectionsDataSource {
  final ApiClient _apiClient;

  AppSectionsDataSourceImpl(this._apiClient);

  @override
  Future<Result<UserDto>> getCurrentUserData() async => executeApi(() async {
    final response = await _apiClient.getCurrentUserData();
    return response.user ?? UserDto();
  });
}
