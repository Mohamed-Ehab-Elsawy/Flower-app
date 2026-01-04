
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flutter/material.dart';

class FullBill extends StatelessWidget {
  const FullBill({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = context.appTheme;
    return Column(

      children: [
        context.h(33),
        _textSection(price: "100", billText: "cart.sub_total".tr(), context: context),
        _textSection(price: "10", billText: "cart.delivery_fee".tr(), context: context),
        Divider(
          color: theme.secondary[70],
        ),
        _textSection(
          price: "110",
          billText: "cart.total".tr(),
          context: context,
          textStyle: theme.medium20.copyWith(
            fontSize: 18,
            color: theme.surface,
          ),
        ),
        context.h(48),
      ],
    ).toSliverBoxAdapter;
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
