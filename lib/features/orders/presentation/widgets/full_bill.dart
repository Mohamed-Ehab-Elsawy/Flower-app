import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FullBill extends StatelessWidget {
  const FullBill({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      children: [
        BlocBuilder<OrderViewModel, OrderState>(
          builder: (context, state) {
            final cartMap = state.orders?.data ?? {};
            if (cartMap.isEmpty) {
              return const SizedBox.shrink();
            }
            final subTotal = _calculateSubtotal(cartMap);
            final totalPrice = subTotal + deliveryFee;
            return Column(
              children: [
                context.h(33),
                _textSection(
                  price: subTotal.toString(),
                  billText: "cart.sub_total".tr(),
                  context: context,
                ),
                _textSection(
                  price: deliveryFee.toString(),
                  billText: "cart.delivery_fee".tr(),
                  context: context,
                ),
                Divider(color: theme.secondary[70]),
                _textSection(
                  price: totalPrice.toString(),
                  billText: "cart.total".tr(),
                  context: context,
                  textStyle: theme.medium20.copyWith(
                    fontSize: 18,
                    color: theme.surface,
                  ),
                ),
                context.h(48),
              ],
            );
          },
        ),
      ],
    );

  }
  double _calculateSubtotal(Map<String, CartItemEntity> cartMap) {
    double total = 0.0;

    for (final item in cartMap.values) {
      final itemPrice = item.price ?? item.product?.price ?? 0;
      final itemQuantity = item.quantity ?? 0;
      total += itemPrice * itemQuantity;
    }

    return total;
  }


  Widget _textSection({
    required BuildContext context,
    required String billText,
    required String price,
    TextStyle? textStyle,
  }) {
    late final theme = context.appTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            billText,
            style: textStyle ?? theme.medium16.copyWith(color: theme.grey),
          ),
          Text(
            price + r"$",
            style: textStyle ?? theme.medium16.copyWith(color: theme.grey),
          ),
        ],
      ),
    );
  }
}
