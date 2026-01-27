import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entity/order_enyity.dart';
import 'package:flower_app/features/checkout/domain/entity/sessionEntity.dart';
import 'package:flower_app/features/checkout/domain/repo/check_out_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckOutUseCase {
  CheckOutRepo checkOutRepo;

  CheckOutUseCase(this.checkOutRepo);

  Future<Result<SessionEntity>> checkoutCreditCard(
    CheckOutOrderRequest checkoutRequest,
  ) {
    return checkOutRepo.checkoutCreditCard(checkoutRequest);
  }

  Future<Result<OrderEntity>> checkoutCash(
    CheckOutOrderRequest checkoutRequest,
  ) {
    return checkOutRepo.checkoutCash(checkoutRequest);
  }

  Future<Result<List<AddressesEntity>>> getUserAddresses() {
    return checkOutRepo.getUserAddresses();
  }
}
