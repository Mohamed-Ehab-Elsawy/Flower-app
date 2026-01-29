import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'address_response_dto.g.dart';

@JsonSerializable()
class AddressResponseDto extends Equatable {
  final String message;
  final List<AddressDto> address;

  const AddressResponseDto({required this.message, required this.address});

  factory AddressResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseDtoToJson(this);

  @override
  List<Object?> get props => [message, address];
}

@JsonSerializable()
class AddressDto extends Equatable {
  @JsonKey(name: '_id')
  final String? id;

  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String username;

  const AddressDto({
    this.id,
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);

  @override
  List<Object?> get props => [id, street, phone, city, lat, long, username];
}
