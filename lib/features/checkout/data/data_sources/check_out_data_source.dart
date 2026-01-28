import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/data/models/response/address_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/order_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/session_dto.dart';

abstract class CheckOutDataSource {
  Future<Result<SessionDto>> checkoutCreditCard(
    CheckOutOrderRequest checkoutRequest,
  );

  Future<Result<OrderDto>> checkoutCash(CheckOutOrderRequest checkoutRequest);

  Future<Result<List<AddressesDto>>> getUserAddresses();
}
