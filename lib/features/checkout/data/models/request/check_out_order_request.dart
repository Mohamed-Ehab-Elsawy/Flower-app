import 'package:json_annotation/json_annotation.dart';

part 'check_out_order_request.g.dart';

@JsonSerializable()
class CheckOutOrderRequest {
  @JsonKey(name: "shippingAddress")
  final ShippingAddress? shippingAddress;

  CheckOutOrderRequest({this.shippingAddress});

  factory CheckOutOrderRequest.fromJson(Map<String, dynamic> json) {
    return _$CheckOutOrderRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CheckOutOrderRequestToJson(this);
  }
}

@JsonSerializable()
class ShippingAddress {
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

  ShippingAddress({this.street, this.phone, this.city, this.lat, this.long});

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return _$ShippingAddressFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ShippingAddressToJson(this);
  }
}
