import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';

class FilterItemWidget<T> extends StatelessWidget {
  final T value;
  final String title;

  const FilterItemWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => RadioGroup.maybeOf<T>(context)?.onChanged.call(value),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(title.tr(), style: context.appTheme.medium16),
              ),
              Radio<T>(
                value: value,
                fillColor: WidgetStateProperty.all(context.appTheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
