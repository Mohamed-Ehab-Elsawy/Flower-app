import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/domain/entity/sessionEntity.dart';
import 'package:flower_app/features/checkout/domain/repo/check_out_repo.dart';

class CheckOutUseCase {
  CheckOutRepo checkOutRepo;

  CheckOutUseCase(this.checkOutRepo);

  Future<Result<SessionEntity>> checkout(CheckOutOrderRequest checkoutRequest) {
    return checkOutRepo.checkout(checkoutRequest);
  }
}
