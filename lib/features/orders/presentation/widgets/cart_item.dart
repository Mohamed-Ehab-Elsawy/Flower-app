import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/orders/presentation/widgets/counter_item.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = context.appTheme;
    return Card.outlined(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      color: theme.backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: theme.grey)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          spacing: 8,
          children: [
            //assets
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset("assets/image/images.png", height: 101),
            ),
            //Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Red roses", style: theme.medium16),
                          Text(
                            "15 Pink Rose Bouquet",
                            style: theme.regular14.copyWith(
                              fontSize: 13,
                              color: theme.grey,
                            ),
                          ),
                        ],
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete_outline_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "EGP 600",
                        style: theme.semiBold12.copyWith(fontSize: 14),
                      ),
                      const CounterItem(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
