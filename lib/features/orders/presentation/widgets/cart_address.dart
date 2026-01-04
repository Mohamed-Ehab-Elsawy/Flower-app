
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';

class CartAddress extends StatelessWidget {
  const CartAddress({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = context.appTheme;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: Row(
        spacing: 8,
        children: [
          Icon(Icons.location_on_outlined, color: theme.grey),
          Expanded(

            child: Text.rich(
              TextSpan(
                style: theme.medium13.copyWith(fontSize: 16),
                children: [
                  TextSpan(
                    text: "cart.deliver_to".tr(),
                    style: theme.medium13.copyWith(color: theme.grey,fontSize: 16),
                  ),
                  const TextSpan(
                    text: "2XVP+XC - Sheikh Zayed xxxxxxxxxxxxxxxxxxxxxxxxxx",
                  ),
                ],
              ),

              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_outlined),
        ],
      ).toSliverBoxAdapter,
    );
  }
}