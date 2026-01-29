import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'address_request_dto.g.dart';

@JsonSerializable()
class AddressRequestDto extends Equatable {
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final String? username;

  const AddressRequestDto({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
  });

  factory AddressRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddressRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressRequestDtoToJson(this);

  @override
  List<Object?> get props => [street, phone, city, lat, long, username];
}
