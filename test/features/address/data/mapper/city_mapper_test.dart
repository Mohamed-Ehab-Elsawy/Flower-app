import 'package:flower_app/features/address/data/mapper/city_mapper.dart';
import 'package:flower_app/features/address/data/models/city_model.dart';
import 'package:flower_app/features/address/domain/entities/city_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test City Mapper", () {
    test('test toEntity on CityModel should return CityEntity', () {
      //arrange
      const cityModel = CityDto(
        id: '1',
        governorateId: '1',
        cityNameAr: 'القاهرة',
        cityNameEn: 'Cairo',
      );

      //act
      final cityEntity = cityModel.toEntity();

      //assert
      expect(cityEntity, isA<CityEntity>());
      expect(cityEntity.nameAr, cityModel.cityNameAr);
      expect(cityEntity.nameEn, cityModel.cityNameEn);
      expect(cityEntity.governorateId, cityModel.governorateId);
    });

    test(
      'test toEntity on CityModel with null values should return empty strings',
      () {
        //arrange
        const cityModel = CityDto(
          id: '1',
          governorateId: null,
          cityNameAr: null,
          cityNameEn: null,
        );

        //act
        final cityEntity = cityModel.toEntity();

        //assert
        expect(cityEntity.nameAr, '');
        expect(cityEntity.nameEn, '');
        expect(cityEntity.governorateId, '');
      },
    );
  });
}
