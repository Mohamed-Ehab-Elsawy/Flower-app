import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/helper/assets_manager.dart';
import 'package:flower_app/core/helper/load_json.dart';
import 'package:flower_app/features/address/data/data_source/address_data_source.dart';
import 'package:flower_app/features/address/data/models/city_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AddressDataSource)
class LocalAddressDataSource implements AddressDataSource {
  @override
  Future<Result<List<CityModel>>> getCities() async {
    return executeApi(() => LoadAsset.loadCitiesList(AssetsManager.citiesJson));
  }
}
