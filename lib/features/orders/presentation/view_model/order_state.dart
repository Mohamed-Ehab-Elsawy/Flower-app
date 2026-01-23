import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';

class OrderState extends Equatable {
  final BaseState<Map<String, CartItemEntity>>? orders;
  final BaseState<CartResponseEntity>? cartOrders;

  const OrderState({this.orders, this.cartOrders});
  OrderState copyWith({
    BaseState<Map<String, CartItemEntity>>? ordes,
    BaseState<CartResponseEntity>? cartOrders,
  }) {
    return OrderState(
      orders: ordes ?? orders,
      cartOrders: cartOrders ?? this.cartOrders,
    );
  }

  @override
  List<Object?> get props => [orders, cartOrders];
}

sealed class Intent {}

class GetOrders extends Intent {}

class ClearCart extends Intent {}

class UpdateProductQuantity extends Intent {
  final String productId;
  final int quantity;
  UpdateProductQuantity({required this.productId, required this.quantity});
}

class AddItemToCart extends Intent {
  final ProductsEntity product;
  AddItemToCart({required this.product});
}

class RemoveProductFromCart extends Intent {
  final String productId;
  RemoveProductFromCart({required this.productId});
}

sealed class UiEvents {}

class AddToCartEvent extends UiEvents {
  AddToCartEvent();
}

class UnAuthorizedEvent extends UiEvents {
  final String errorMessage;

  UnAuthorizedEvent({required this.errorMessage});
}
