import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entity/order_enyity.dart';
import 'package:flower_app/features/checkout/domain/entity/session_entity.dart';

abstract class CheckOutRepo {
  Future<Result<SessionEntity>> checkoutCreditCard(
    CheckOutOrderRequest checkoutRequest,
  );

  Future<Result<OrderEntity>> checkoutCash(
    CheckOutOrderRequest checkoutRequest,
  );

  Future<Result<List<AddressesEntity>>> getUserAddresses();
}
