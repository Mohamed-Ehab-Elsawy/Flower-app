import 'package:flower_app/features/checkout/domain/entity/address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_dto.g.dart';

@JsonSerializable()
class AddressesDto {
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "_id")
  final String? id;

  AddressesDto({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });

  factory AddressesDto.fromJson(Map<String, dynamic> json) {
    return _$AddressesDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressesDtoToJson(this);
  }

  AddressesEntity toEntity() {
    return AddressesEntity(
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username,
      id: id,
    );
  }
}
