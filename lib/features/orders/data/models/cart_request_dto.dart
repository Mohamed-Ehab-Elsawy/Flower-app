import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_request_dto.g.dart';

@JsonSerializable()
class CartRequestDto extends Equatable {
  @JsonKey(name: 'product')
  final String productId;
  @JsonKey(name: 'quantity')
  final int quantity;

  const CartRequestDto({required this.productId, required this.quantity});

  factory CartRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CartRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartRequestDtoToJson(this);

  @override
  List<Object?> get props => [productId, quantity];
}
