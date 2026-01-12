import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/constants/app_paths.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_viewmodel.dart';
import 'package:flower_app/features/orders/presentation/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderViewModel, OrderState>(
      builder: (context, state) {
        switch (state.ordes!.requestState) {
          case RequestState.init:
            return _emptyCart();

          case RequestState.loading:
            final orders = state.ordes?.data?.values.toList() ?? [];
            if (orders.isEmpty) {
              return _emptyCart();
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: orders.length,
                (context, index) => CartItem(itemEntity: orders[index]),
              ),
            );
          case RequestState.loaded:
            final orders = state.ordes!.data?.values.toList();
            if (orders!.isEmpty) {
              return _emptyCart();
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: state.ordes!.data!.length,
                (context, index) => CartItem(itemEntity: orders[index]),
              ),
            );
          case RequestState.error:
            return Center(
              child: Text(state.ordes?.errorMessage ?? " "),
            ).toSliverBoxAdapter;
        }
      },
    );
  }

  SliverToBoxAdapter _emptyCart() {
    return Center(child: Lottie.asset(AppPaths.emptyCart)).toSliverBoxAdapter;
  }
}
