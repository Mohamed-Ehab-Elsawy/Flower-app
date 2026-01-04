import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = context.appTheme;
    return  SliverAppBar(
      titleSpacing:-14,
      backgroundColor: theme.backgroundColor,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      scrolledUnderElevation: 0,
      pinned: true,
      title:RichText(
        text: TextSpan(
          children: [
            TextSpan(text: "cart.cart".tr(), style: theme.medium20),
            TextSpan(
              text: "\t(3 ${"cart.items".tr()})",
              style: theme.medium20.copyWith(color: theme.grey),
            ),
          ],
        ),
      ),
    );
  }
}
