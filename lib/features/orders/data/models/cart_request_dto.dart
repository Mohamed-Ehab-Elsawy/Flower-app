
import 'package:json_annotation/json_annotation.dart';
part 'cart_request_dto.g.dart';
@JsonSerializable()
class CartRequestDto{
  @JsonKey(name: 'product')
  final String productId;
@JsonKey(name: 'quantity')
  final int quantity;

  const CartRequestDto({required this.productId,required this.quantity});

  Map<String, dynamic> toJson() => _$CartRequestDtoToJson(this);

}