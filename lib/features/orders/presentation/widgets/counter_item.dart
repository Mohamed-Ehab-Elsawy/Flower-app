import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterItem extends StatelessWidget {
  const CounterItem({super.key, required this.cartItem});
  final CartItemEntity cartItem;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<OrderViewModel>();
    final theme = context.appTheme;
    return Row(
      children: [
        IconButton(
          onPressed:
              cartItem
                  .canDecrement // Using entity method
              ? () {
                  viewModel.doIntent(
                    UpdateProductQuantity(
                      productId: cartItem.product!.id!,
                      quantity: cartItem.quantity! - 1,
                    ),
                  );
                }
              : null,
          icon: Icon(Icons.remove, color: theme.surface),
        ),
        Text(
          cartItem.quantity.toString(),
          textAlign: TextAlign.center,
          style: theme.semiBold12.copyWith(color: theme.surface, fontSize: 14),
        ),
        IconButton(
          onPressed: () {
            viewModel.doIntent(
              UpdateProductQuantity(
                productId: cartItem.product!.id!,
                quantity: cartItem.quantity! + 1,
              ),
            );
          },
          icon: Icon(Icons.add, color: theme.surface),
        ),
      ],
    );
  }
}
