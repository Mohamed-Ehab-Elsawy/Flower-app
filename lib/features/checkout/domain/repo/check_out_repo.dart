import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/domain/entity/sessionEntity.dart';

abstract class CheckOutRepo {
  Future<Result<SessionEntity>> checkout(CheckOutOrderRequest checkoutRequest);
}
