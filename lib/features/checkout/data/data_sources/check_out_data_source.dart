import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/data/models/response/session_dto.dart';

abstract class CheckOutDataSource {
  Future<Result<SessionDto>> checkout(CheckOutOrderRequest checkoutRequest);
}
