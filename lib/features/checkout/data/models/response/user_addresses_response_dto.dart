import 'package:flower_app/features/checkout/data/models/response/address_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_addresses_response_dto.g.dart';

@JsonSerializable()
class UserAddressesResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "addresses")
  final List<AddressesDto>? addresses;

  UserAddressesResponseDto({this.message, this.addresses});

  factory UserAddressesResponseDto.fromJson(Map<String, dynamic> json) {
    return _$UserAddressesResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserAddressesResponseDtoToJson(this);
  }
}
