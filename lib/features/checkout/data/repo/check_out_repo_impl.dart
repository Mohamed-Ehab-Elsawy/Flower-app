import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/data_sources/check_out_data_source.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/data/models/response/address_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/order_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/session_dto.dart';
import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entity/order_enyity.dart';
import 'package:flower_app/features/checkout/domain/entity/session_entity.dart';
import 'package:flower_app/features/checkout/domain/repo/check_out_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckOutRepo)
class CheckOutRepoImpl implements CheckOutRepo {
  CheckOutDataSource checkOutDataSource;

  CheckOutRepoImpl(this.checkOutDataSource);

  @override
  Future<Result<SessionEntity>> checkoutCreditCard(
    CheckOutOrderRequest checkoutRequest,
  ) async {
    Result<SessionDto> sessionDtoResponse = await checkOutDataSource
        .checkoutCreditCard(checkoutRequest);
    switch (sessionDtoResponse) {
      case Success<SessionDto>():
        {
          SessionDto sessionDto = sessionDtoResponse.data;
          SessionEntity sessionEntity = sessionDto.toEntity();
          return Success<SessionEntity>(sessionEntity);
        }

      case Failure<SessionDto>():
        {
          return Failure<SessionEntity>(sessionDtoResponse.errorMessage);
        }
    }
  }

  @override
  Future<Result<OrderEntity>> checkoutCash(
    CheckOutOrderRequest checkoutRequest,
  ) async {
    Result<OrderDto> orderDtoResponse = await checkOutDataSource.checkoutCash(
      checkoutRequest,
    );
    switch (orderDtoResponse) {
      case Success<OrderDto>():
        {
          OrderDto orderDto = orderDtoResponse.data;
          OrderEntity orderEntity = orderDto.toEntity();
          return Success<OrderEntity>(orderEntity);
        }

      case Failure<OrderDto>():
        {
          return Failure<OrderEntity>(orderDtoResponse.errorMessage);
        }
    }
  }

  @override
  Future<Result<List<AddressesEntity>>> getUserAddresses() async {
    Result<List<AddressesDto>> addressDto = await checkOutDataSource
        .getUserAddresses();
    switch (addressDto) {
      case Success<List<AddressesDto>>():
        {
          final items = addressDto.data;
          final address = items.map((dto) => dto.toEntity()).toList();

          return Success(address);
        }
      case Failure<List<AddressesDto>>():
        {
          return Failure(addressDto.errorMessage);
        }
    }
  }
}
