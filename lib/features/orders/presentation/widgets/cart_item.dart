import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_viewmodel.dart';
import 'package:flower_app/features/orders/presentation/widgets/counter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.itemEntity});
  final CartItemEntity itemEntity;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return BlocBuilder<OrderViewModel, OrderState>(
      builder: (context, state) {
        // Get current item from state
        final cartMap = state.ordes?.data ?? {};
        final currentItem = cartMap[itemEntity.product!.id!] ?? itemEntity;

        return Card.outlined(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: theme.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: theme.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              spacing: 8,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: currentItem.product!.imageCover!,
                    height: 101,
                    width: 96,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              currentItem.product?.title ?? "",
                              style: theme.medium16.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<OrderViewModel>().doIntent(
                                RemoveProductFromCart(
                                  productId: currentItem.product!.id!,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        currentItem.product?.slug ?? "",
                        style: theme.regular14.copyWith(
                          fontSize: 13,
                          overflow: TextOverflow.ellipsis,
                          color: theme.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentItem
                                .formattedTotalPrice, // Using entity method
                            style: theme.semiBold12.copyWith(fontSize: 14),
                          ),
                          CounterItem(cartItem: currentItem),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
