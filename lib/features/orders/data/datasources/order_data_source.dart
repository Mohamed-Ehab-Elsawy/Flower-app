import 'package:flower_app/core/error_handling/base_response_result_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/orders/data/models/order_response_dto.dart';

abstract interface class OrderDataSource {
  Future<Result<CartResponseDto>> addProductToCart(CartItemDto cartItem);

  Future<Result<CartResponseDto>> updateCartProductQuantity(
    String id,
    int quantity,
  );

  Future<Result<CartResponseDto>> getOrders();

  Future<Result<CartResponseDto>> removeSpecificProductFromCart(String id);

  Future<Result<SuccessResponseDto>> clearCart();
}
