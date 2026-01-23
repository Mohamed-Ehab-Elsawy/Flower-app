import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_response_dto.g.dart';

@JsonSerializable()
class CartResponseDto extends Equatable {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'numOfCartItems')
  final int? numOfCartItems;

  @JsonKey(name: 'cart')
  final CartDto? cart;

  const CartResponseDto({this.message, this.numOfCartItems, this.cart});

  factory CartResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CartResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseDtoToJson(this);

  @override
  List<Object?> get props => [message, numOfCartItems, cart];
}

// Cart DTO
@JsonSerializable()
class CartDto extends Equatable {
  @JsonKey(name: 'user')
  final String? user;

  @JsonKey(name: 'cartItems')
  final List<CartItemDto>? cartItems;

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'appliedCoupons')
  final List<dynamic>? appliedCoupons;

  @JsonKey(name: 'totalPrice')
  final double? totalPrice;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  @JsonKey(name: '__v')
  final int? version;

  const CartDto({
    this.user,
    this.cartItems,
    this.id,
    this.appliedCoupons,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartDtoToJson(this);

  @override
  List<Object?> get props => [
    user,
    cartItems,
    id,
    appliedCoupons,
    totalPrice,
    createdAt,
    updatedAt,
    version,
  ];
}

// Cart Item DTO
@JsonSerializable()
class CartItemDto extends Equatable {
  @JsonKey(name: 'product')
  final ProductsDto? product;

  @JsonKey(name: 'price')
  final double? price;

  @JsonKey(name: 'quantity')
  final int? quantity;

  @JsonKey(name: '_id')
  final String? id;

  const CartItemDto({this.product, this.price, this.quantity, this.id});

  factory CartItemDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemDtoToJson(this);

  @override
  List<Object?> get props => [product, price, quantity, id];
}
