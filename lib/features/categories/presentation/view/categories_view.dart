import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/constants/app_dimensions.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/core/widgets/custom_products_grid_list_builder.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_cubit.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_intents.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_states.dart';
import 'package:flower_app/features/categories/presentation/view/widgets/categories_search_and_filter_widget.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../orders/presentation/view_model/order_viewmodel.dart';
import 'manager/categories_view_events.dart';

class CategoriesView extends StatefulWidget {
  final int? index;

  const CategoriesView({super.key, this.index});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final ScrollController _scrollController = ScrollController();
  bool _showFilterButton = true;
  late StreamSubscription _orderSubscription;
  @override
  void initState() {
    super.initState();
    context.read<CategoriesViewCubit>().doIntent(
      InitCategoriesViewIntent(index: widget.index),
    );
    _scrollListener();
    _eventsListener();
    _orderStreamListener();
  }

  void _orderStreamListener() {
    _orderSubscription = context.read<OrderViewModel>().uiEventsStream.listen((
      event,
    ) {
      switch (event) {
        case AddToCartEvent():
          //show toast
          if (!mounted) return;
          Toast.showToast(context, "Product added to cart");
        case UnAuthorizedEvent():
          //show toast
          if (!mounted) return;
          Toast.showAppDialog(context: context, title: event.errorMessage);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _orderSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: Stack(
          children: [
            BlocBuilder<CategoriesViewCubit, CategoriesViewStates>(
              builder: (context, state) => DefaultTabController(
                length: state.categories?.data?.length ?? 0,
                initialIndex: widget.index ?? 0,
                child: Column(
                  children: [
                    const CategoriesSearchAndFilterWidget(),
                    context.h(8),
                    state.categories?.requestState == RequestState.loaded
                        ? TabBar(
                            isScrollable: true,
                            onTap: (index) {
                              context.read<CategoriesViewCubit>().doIntent(
                                GetProductsByCategoryIntent(
                                  categoryId: state.categories?.data?[index].id,
                                ),
                              );
                            },
                            tabs:
                                state.categories?.data
                                    ?.map(
                                      (category) => Tab(text: category.name),
                                    )
                                    .toList() ??
                                [],
                          )
                        : const SizedBox.shrink(),
                    context.h(8),
                    Expanded(
                      child:
                          state.productsStates?.requestState ==
                              RequestState.loaded
                          ? CustomProductsGridListBuilder(
                              products: state.productsStates?.data,
                              scrollController: _scrollController,
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                color: context.appTheme.primary,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            // Filter Button
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedSlide(
                offset: _showFilterButton ? Offset.zero : const Offset(0, 1),
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child: AnimatedOpacity(
                  opacity: _showFilterButton ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Center(child: _filterButton()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterButton() => ElevatedButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.tune, color: Colors.white),
    label: Text(
      'Filter'.tr(),
      style: context.appTheme.medium16.copyWith(color: Colors.white),
    ),
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      minimumSize: Size.zero,
    ),
  );

  void _eventsListener() {
    context.read<CategoriesViewCubit>().uiEvents.listen((event) {
      if (event is CategoriesViewShowErrorEvent && mounted) {
        Toast.showToast(context, event.errorMessage);
      }
    });
  }

  void _scrollListener() {
    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;

      if (direction == ScrollDirection.reverse && _showFilterButton) {
        setState(() => _showFilterButton = false);
      } else if (direction == ScrollDirection.forward && !_showFilterButton) {
        setState(() => _showFilterButton = true);
      }
    });
  }
}
