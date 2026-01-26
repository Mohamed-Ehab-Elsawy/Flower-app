import 'package:flower_app/core/constants/constants.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';
import 'package:flower_app/features/address/domain/repo/address_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoadCityUseCase {
  final AddressRepo _addressRepo;

  const LoadCityUseCase(this._addressRepo);

  Future<Result<Map<String, List<CityEntity>>>> call(String lang) async {
    final response = await _addressRepo.getCities();
    switch (response) {
      case Success<List<CityEntity>>():
        final cities = response.data;
        final Map<String, List<CityEntity>> governoratesMap = {};

        for (var city in cities) {
          final govData = egyptGovernorates[city.governorateId];

          final String govNameKey = lang == 'ar'
              ? (govData?['ar'] ?? city.governorateId)
              : (govData?['en'] ?? city.governorateId);

          if (!governoratesMap.containsKey(govNameKey)) {
            governoratesMap[govNameKey] = [];
          }
          governoratesMap[govNameKey]!.add(city);
        }
        return Success(governoratesMap);
      case Failure<List<CityEntity>>():
        return Failure(response.errorMessage);
    }
  }
}
