import 'package:flower_app/core/app/data/mapper/product_mapper.dart';
import 'package:flower_app/features/orders/data/models/order_response_dto.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';




// Extension for CartItemDto
extension CartItemDtoToEntityExtension on CartItemDto {
  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id ?? '',
      product: product?.toEntity(),
      price: price,
      quantity: quantity,
    );
  }
}


// Extension for CartItemDto
extension CartItemEntityToDtoExtension on CartItemEntity {
  CartItemDto toDto() {
    return CartItemDto(
      id: id ?? '',
      product: product?.toDto(),
      price: price,
      quantity: quantity,
    );
  }
}

// Extension for CartDto
extension CartDtoToEntityExtension on CartDto {
  CartEntity toEntity() {
    return CartEntity(
      id: id ,
      userId: user ,
      items: cartItems?.map((item)=>item.toEntity()).toList(),
      appliedCoupons: appliedCoupons?.map((e) => e.toString()).toList() ?? [],
      totalPrice: totalPrice,
      createdAt: createdAt ,
      updatedAt: updatedAt ,
    );
  }
}

// Extension for CartResponseDto
extension CartResponseDtoToEntityExtension on CartResponseDto {
  CartResponseEntity toEntity() {
    return CartResponseEntity(
      message: message,
      numOfCartItems: numOfCartItems,
      cart: cart?.toEntity(),
    );
  }
}



