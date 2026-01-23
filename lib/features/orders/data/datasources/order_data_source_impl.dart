import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/constants/end_points.dart';
import 'package:flower_app/core/error_handling/base_response_result_dto.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/orders/data/datasources/order_data_source.dart';
import 'package:flower_app/features/orders/data/models/cart_request_dto.dart';
import 'package:flower_app/features/orders/data/models/order_response_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OrderDataSource)
class OrderDataSourceImpl implements OrderDataSource {
  final ApiClient _apiClient;

  OrderDataSourceImpl(this._apiClient);

  @override
  Future<Result<CartResponseDto>> addProductToCart(CartItemDto cartItem) {
    final CartRequestDto cartRequestDto = CartRequestDto(
      productId: cartItem.id!,
      quantity: cartItem.quantity!,
    );
    return executeApi(
      () async => await _apiClient.addProductToCart(cartRequestDto),
    );
  }

  @override
  Future<Result<SuccessResponseDto>> clearCart() {
    return executeApi(() async => await _apiClient.clearCart());
  }

  @override
  Future<Result<CartResponseDto>> getOrders() {
    return executeApi(() async => await _apiClient.getLoggedUserCart());
  }

  @override
  Future<Result<CartResponseDto>> removeSpecificProductFromCart(String id) {
    return executeApi(() async => await _apiClient.removeProductFromCart(id));
  }

  @override
  Future<Result<CartResponseDto>> updateCartProductQuantity(
    String id,
    int quantity,
  ) {
    final Map<String, int> quantityMap = {EndPoints.quantity: quantity};
    return executeApi(
      () async => await _apiClient.updateProductQuantity(id, quantityMap),
    );
  }
}
