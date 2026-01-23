import 'package:flower_app/core/error_handling/base_response_result_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';

abstract interface class OrderRepo {
  Future<Result<CartResponseEntity>> addProductToCart(CartItemEntity cartItem);

  Future<Result<CartResponseEntity>> updateCartProductQuantity(
    String id,
    int quantity,
  );

  Future<Result<CartResponseEntity>> getOrders();

  Future<Result<CartResponseEntity>> removeSpecificProductFromCart(String id);

  Future<Result<SuccessResponseDto>> clearCart();
}
