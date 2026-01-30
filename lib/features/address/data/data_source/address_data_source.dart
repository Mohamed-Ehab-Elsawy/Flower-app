import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/address/data/models/city_model.dart';

abstract interface class AddressDataSource {
  Future<Result<List<CityDto>>> getCities();
}
