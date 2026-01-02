
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';

class UserAddress extends StatelessWidget {
  const UserAddress({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;
    return SliverPadding(
      padding: const EdgeInsets.only(left: 16),
      sliver: Row(
        spacing: 8,
        children: [
          const Icon(Icons.location_on_outlined),
          Text(
            "Deliver to 2XVP+XC - Sheikh Zayed",
            style: theme.medium13.copyWith(fontSize: 14),
          ),
          Icon(Icons.keyboard_arrow_down_outlined, color: theme.primary),
        ],
      ).toSliverBoxAdapter,
    );
  }
}

