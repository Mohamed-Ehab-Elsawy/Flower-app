import 'package:flower_app/features/address/data/models/city_model.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';

extension CityMapper on CityModel {
  CityEntity toEntity() => CityEntity(
    nameAr: cityNameAr ?? '',
    nameEn: cityNameEn ?? '',
    governorateId: governorateId ?? '',
  );
}
