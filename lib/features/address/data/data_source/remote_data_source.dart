import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/address/data/models/address_request_dto.dart';
import 'package:flower_app/features/address/data/models/address_response_dto.dart';

abstract interface class RemoteDataSource {
  Future<Result<AddressResponseDto>> addAddress(
    AddressRequestDto addressDetails,
  );

  Future<Result<AddressResponseDto>> updateAddress(
    AddressRequestDto addressDetails,
    String id,
  );

  Future<Result<AddressResponseDto>> deleteAddress(String id);

  Future<Result<AddressResponseDto>> getLoggedUserAddress();
}
