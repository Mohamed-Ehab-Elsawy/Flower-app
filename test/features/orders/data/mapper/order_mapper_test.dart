import 'package:flower_app/features/orders/data/mapper/order_mapper.dart';
import 'package:flower_app/features/orders/data/models/order_response_dto.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test Cart Mapper", () {
    test('test toEntity on cartItemDto should return cartItemEntity', () {
      //arrange
      const cartItemDto = CartItemDto(id: '1');

      //act
      final cartItemEntity = cartItemDto.toEntity();

      //assert
      expect(cartItemEntity, isA<CartItemEntity>());
      expect(cartItemEntity.id, cartItemDto.id);
    });

    test('test toEntity on cartItemEntity should return cartItemDto', () {
      //arrange
      const cartItemEntity = CartItemEntity(id: '1');

      //act
      final cartItemDto = cartItemEntity.toDto();

      //assert
      expect(cartItemEntity, isA<CartItemEntity>());
      expect(cartItemEntity.id, cartItemDto.id);
    });

    test('test toEntity on cartDto should return cartEntity', () {
      //arrange
      const cartDto = CartDto(id: '1');

      //act
      final cartEntity = cartDto.toEntity();

      //assert
      expect(cartEntity, isA<CartEntity>());
      expect(cartEntity.id, cartDto.id);
    });

    test(
      'test toEntity on cartResponseDto should return cartResponseEntity',
      () {
        //arrange
        const cartResponseDto = CartResponseDto(message: 'message');

        //act
        final cartResponseEntity = cartResponseDto.toEntity();

        //assert
        expect(cartResponseEntity, isA<CartResponseEntity>());
        expect(cartResponseEntity.message, cartResponseDto.message);
      },
    );
  });
}
