import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/data_sources/check_out_data_source.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/data/models/response/check_out_order_response.dart';
import 'package:flower_app/features/checkout/data/models/response/session_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckOutDataSource)
class CheckOutDataSourceImpl implements CheckOutDataSource {
  final ApiClient _apiClient;

  CheckOutDataSourceImpl(this._apiClient);

  @override
  Future<Result<SessionDto>> checkout(CheckOutOrderRequest checkoutRequest) {
    return executeApi<SessionDto>(() async {
      final CheckOutOrderResponseDto checkOutOrderResponse = await _apiClient
          .checkout(checkoutRequest);
      return checkOutOrderResponse.session ?? SessionDto();
    });
  }
}
