import 'package:flower_app/features/address/data/models/address_request_dto.dart';
import 'package:flower_app/features/address/data/models/address_response_dto.dart';
import 'package:flower_app/features/address/domain/entities/address_request_entity.dart';
import 'package:flower_app/features/address/domain/entities/address_response_entity.dart';

extension AddressDtoMapper on AddressDto {
  AddressEntity toEntity() {
    return AddressEntity(
      id: id,
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username,
    );
  }
}

extension AddressEntityMapper on AddressRequestEntity {
  AddressRequestDto toDto() {
    return AddressRequestDto(
      street: street,
      phone: phone,
      city: city,
      username: username,
      lat: lat,
      long: long,
    );
  }
}

extension AddressResponseDtoMapper on AddressResponseDto {
  AddressResponseEntity toEntity() {
    return AddressResponseEntity(
      message: message,
      address: address?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
