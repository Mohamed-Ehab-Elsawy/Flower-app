import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/address/domain/entities/address_request_entity.dart';
import 'package:flower_app/features/address/domain/entities/address_response_entity.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';

abstract interface class AddressRepository {
  Future<Result<List<CityEntity>>> getCities();
  Future<Result<AddressResponseEntity>> addAddress(
    AddressRequestEntity addressEntity,
  );
  Future<Result<AddressResponseEntity>> updateAddress(
    AddressRequestEntity addressEntity,
    String id,
  );
  Future<Result<AddressResponseEntity>> deleteAddress(String id);
  Future<Result<AddressResponseEntity>> getLoggedUserAddress();
}
