import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flower_app/features/orders/presentation/widgets/cart_address.dart';
import 'package:flower_app/features/orders/presentation/widgets/cart_appbar.dart';
import 'package:flower_app/features/orders/presentation/widgets/checkout_bill.dart';
import 'package:flower_app/features/orders/presentation/widgets/orders_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/order_viewmodel.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  void initState() {
    if (!mounted) return;
    context.read<OrderViewModel>().doIntent(GetOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [CartAppBar(), CartAddress(), OrdersList(), CheckoutBill()],
      ),
    );
  }
}
