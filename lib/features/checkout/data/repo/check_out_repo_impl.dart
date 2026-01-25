import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/data_sources/check_out_data_source.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/data/models/response/session_dto.dart';
import 'package:flower_app/features/checkout/domain/entity/sessionEntity.dart';
import 'package:flower_app/features/checkout/domain/repo/check_out_repo.dart';

class CheckOutRepoImpl implements CheckOutRepo {
  CheckOutDataSource checkOutDataSource;

  CheckOutRepoImpl(this.checkOutDataSource);

  @override
  Future<Result<SessionEntity>> checkout(
    CheckOutOrderRequest checkoutRequest,
  ) async {
    Result<SessionDto> sessionDtoResponse = await checkOutDataSource.checkout(
      checkoutRequest,
    );
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
}
