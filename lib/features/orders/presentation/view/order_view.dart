import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/orders/presentation/widgets/cart_address.dart';
import 'package:flower_app/features/orders/presentation/widgets/cart_appbar.dart';
import 'package:flower_app/features/orders/presentation/widgets/full_bill.dart';
import 'package:flower_app/features/orders/presentation/widgets/orders_list.dart';
import 'package:flutter/material.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const CartAppBar(),
          const CartAddress(),
          const OrdersList(),
          const FullBill(),
          SliverPadding(
            padding:const EdgeInsets.symmetric(horizontal:16),
            sliver: ElevatedButton(
              style: _buildElevateStyle(context),
              onPressed: () {},
              child: Text("cart.checkout".tr()),
            ).toSliverBoxAdapter,
          ),
        ],
      ),
    );
  }

  ButtonStyle _buildElevateStyle(BuildContext context) {
    late final theme = context.appTheme;
    return ElevatedButton.styleFrom(
      textStyle: theme.medium20.copyWith(fontSize: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
