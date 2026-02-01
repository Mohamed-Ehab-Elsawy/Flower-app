import 'package:flower_app/features/checkout/data/models/response/address_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AddressesDto addressesDto;
  test(
    'test  toEntity method should return AddressesEntity with same value',
    () {
      addressesDto = AddressesDto(
        street: "street",
        phone: "phone",
        city: "city",
        lat: "lat",
        long: "long",
        username: "username",
        id: "id",
      );
      final result = addressesDto.toEntity();
      expect(result.street, equals(addressesDto.street));
      expect(result.city, equals(addressesDto.city));
      expect(result.lat, equals(addressesDto.lat));
      expect(result.long, equals(addressesDto.long));
      expect(result.username, equals(addressesDto.username));
      expect(result.id, equals(addressesDto.id));
    },
  );
  test(
    'test  toEntity method with null value should return AddressesEntity with null value',
    () {
      addressesDto = AddressesDto(
        street: null,
        phone: null,
        city: null,
        lat: null,
        long: null,
        username: null,
        id: null,
      );
      final result = addressesDto.toEntity();
      expect(result.street, isNull);
      expect(result.city, isNull);
      expect(result.lat, isNull);
      expect(result.long, isNull);
      expect(result.username, isNull);
      expect(result.id, isNull);
    },
  );
}
