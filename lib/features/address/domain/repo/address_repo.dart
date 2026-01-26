import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';

abstract interface class AddressRepo {
  Future<Result<List<CityEntity>>> getCities();
}
