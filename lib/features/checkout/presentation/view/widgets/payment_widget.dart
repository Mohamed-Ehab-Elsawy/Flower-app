import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/checkout/presentation/models/payment_method_model.dart';
import 'package:flutter/material.dart';

class PaymentWidget extends StatelessWidget {
  final PaymentMethodModel? selectedMethod;

  const PaymentWidget({super.key, required this.selectedMethod});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: PaymentMethodModel.values.map((method) {
        final isSelected = selectedMethod == method;

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: isSelected
                ? Border.all(color: context.appTheme.primary, width: 2)
                : Border.all(color: Colors.grey.shade300, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: RadioListTile<PaymentMethodModel>(
            value: method,
            title: Text(
              method.displayMethod.tr(),
              style: context.appTheme.medium16.copyWith(color: Colors.black87),
            ),
            activeColor: context.appTheme.primary,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
          ),
        );
      }).toList(),
    );
  }
}
