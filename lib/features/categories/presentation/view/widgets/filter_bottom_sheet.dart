import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/constants/app_dimensions.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_model.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_states.dart';
import 'package:flower_app/features/categories/presentation/view/manager/sort_enum.dart';
import 'package:flower_app/features/categories/presentation/view/widgets/filter_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBottomSheet extends StatelessWidget {
  final VoidCallback onFilterTap;
  final VoidCallback onClearTap;
  final ValueChanged<SortBy?> onFilterChange;

  const FilterBottomSheet({
    super.key,
    required this.onFilterTap,
    required this.onClearTap,
    required this.onFilterChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.pagePadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "sort_by".tr(),
            style: context.appTheme.semiBold18.copyWith(
              color: context.appTheme.primary,
            ),
          ),
          context.h(8),
          BlocBuilder<CategoriesViewModel, CategoriesViewStates>(
            builder: (context, state) {
              return RadioGroup(
                groupValue: state.sortBy,
                onChanged: onFilterChange,
                child: Column(
                  children: [
                    ...SortBy.values.map((sortOption) {
                      final titles = {
                        SortBy.priceLowToHigh: "price_low_to_high",
                        SortBy.priceHighToLow: "price_high_to_low",
                        SortBy.newest: "newest_first",
                        SortBy.oldest: "oldest_first",
                        SortBy.discountFirst: "discount_first",
                      };
                      return FilterItemWidget<SortBy>(
                        title: titles[sortOption] ?? "",
                        value: sortOption,
                      );
                    }),
                  ],
                ),
              );
            },
          ),
          context.h(16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onClearTap,
                  label: Text("clear".tr()),
                  icon: const Icon(Icons.clear_all_rounded),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appTheme.secondary[70]!,
                  ),
                ),
              ),
              context.w(8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onFilterTap,
                  label: Text("filter".tr()),
                  icon: const Icon(Icons.tune),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
