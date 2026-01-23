import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_viewmodel.dart';
import 'package:flower_app/features/orders/presentation/widgets/full_bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutBill extends StatelessWidget {
  const CheckoutBill({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderViewModel, OrderState>(
      builder: (context, state) {
        if ((state.orders?.data ?? {}).isNotEmpty) {
          return Column(
            children: [
              const FullBill(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  style: _buildElevateStyle(context),
                  onPressed: () {},
                  child: Text("cart.checkout".tr()),
                ),
              ),
            ],
          ).toSliverBoxAdapter;
        }
        return const SliverToBoxAdapter();
      },
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
