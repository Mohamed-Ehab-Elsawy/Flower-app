import 'package:flower_app/features/orders/presentation/widgets/cart_item.dart';
import 'package:flutter/material.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return  SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 3,
            (context, index) => const CartItem(),
      ),
    );
  }
}
