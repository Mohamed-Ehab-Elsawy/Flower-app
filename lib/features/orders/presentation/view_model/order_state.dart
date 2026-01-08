import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';

class OrderState extends Equatable {
  final BaseState<Map<String, CartItemEntity>>? ordes;
  final BaseState<CartResponseEntity>? cartOrders;
  const OrderState({this.ordes, this.cartOrders});
  OrderState copyWith({
    BaseState<Map<String, CartItemEntity>>? ordes,
    BaseState<CartResponseEntity>? cartOrders,
  }) {
    return OrderState(
      ordes: ordes ?? this.ordes,
      cartOrders: cartOrders ?? this.cartOrders,
    );
  }

  @override
  List<Object?> get props => [ordes, cartOrders];
}
