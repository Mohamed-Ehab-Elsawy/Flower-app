import 'package:flower_app/features/address/data/mapper/address_mapper.dart';
import 'package:flower_app/features/address/data/models/address_request_dto.dart';
import 'package:flower_app/features/address/data/models/address_response_dto.dart';
import 'package:flower_app/features/address/domain/entities/address_request_entity.dart';
import 'package:flower_app/features/address/domain/entities/address_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test Address Mapper", () {
    test('test toEntity on AddressDto should return AddressEntity', () {
      //arrange
      const addressDto = AddressDto(
        id: '1',
        street: 'street',
        phone: 'phone',
        city: 'city',
        lat: 'lat',
        long: 'long',
        username: 'username',
      );

      //act
      final addressEntity = addressDto.toEntity();

      //assert
      expect(addressEntity, isA<AddressEntity>());
      expect(addressEntity.id, addressDto.id);
      expect(addressEntity.street, addressDto.street);
      expect(addressEntity.phone, addressDto.phone);
      expect(addressEntity.city, addressDto.city);
      expect(addressEntity.lat, addressDto.lat);
      expect(addressEntity.long, addressDto.long);
      expect(addressEntity.username, addressDto.username);
    });

    test(
      'test toDto on AddressRequestEntity should return AddressRequestDto',
      () {
        //arrange
        const addressRequestEntity = AddressRequestEntity(
          street: 'street',
          phone: 'phone',
          city: 'city',
          username: 'username',
          lat: 'lat',
          long: 'long',
        );

        //act
        final addressRequestDto = addressRequestEntity.toDto();

        //assert
        expect(addressRequestDto, isA<AddressRequestDto>());
        expect(addressRequestDto.street, addressRequestEntity.street);
        expect(addressRequestDto.phone, addressRequestEntity.phone);
        expect(addressRequestDto.city, addressRequestEntity.city);
        expect(addressRequestDto.username, addressRequestEntity.username);
        expect(addressRequestDto.lat, addressRequestEntity.lat);
        expect(addressRequestDto.long, addressRequestEntity.long);
      },
    );

    test(
      'test toEntity on AddressResponseDto should return AddressResponseEntity',
      () {
        //arrange
        const addressResponseDto = AddressResponseDto(
          message: 'success',
          address: [AddressDto(id: '1', street: 'street')],
        );

        //act
        final addressResponseEntity = addressResponseDto.toEntity();

        //assert
        expect(addressResponseEntity, isA<AddressResponseEntity>());
        expect(addressResponseEntity.message, addressResponseDto.message);
        expect(
          addressResponseEntity.address?.length,
          addressResponseDto.address?.length,
        );
        expect(
          addressResponseEntity.address?.first.id,
          addressResponseDto.address?.first.id,
        );
      },
    );

    test(
      'test toEntity on AddressResponseDto with null address should return empty list',
      () {
        //arrange
        const addressResponseDto = AddressResponseDto(
          message: 'success',
          address: null,
        );

        //act
        final addressResponseEntity = addressResponseDto.toEntity();

        //assert
        expect(addressResponseEntity.address, []);
      },
    );
  });
}
