import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'address_response_dto.g.dart';

@JsonSerializable()
class AddressResponseDto extends Equatable {
  final String ?message;
  @JsonKey(name: 'addresses')
  final List<AddressDto> ? address;

  const AddressResponseDto({ this.message,  this.address});

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
  @JsonKey(name: 'street')
  final String ?street;
  @JsonKey(name: 'phone')
  final String ?phone;
  @JsonKey(name: 'city')
  final String ?city;
  @JsonKey(name: 'lat')
  final String ?lat;
  @JsonKey(name: 'long')
  final String ?long;
  @JsonKey(name: 'username')
  final String ?username;

  const AddressDto({
    this.id,
     this.street,
     this.phone,
     this.city,
     this.lat,
     this.long,
     this.username,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);

  @override
  List<Object?> get props => [id, street, phone, city, lat, long, username];
}
