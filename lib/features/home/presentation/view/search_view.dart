import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/core/widgets/app_error_view.dart';
import 'package:flower_app/core/widgets/custom_products_grid_list_builder.dart';
import 'package:flower_app/features/home/presentation/view_model/search/search_intent.dart';
import 'package:flower_app/features/home/presentation/view_model/search/search_state.dart';
import 'package:flower_app/features/home/presentation/view_model/search/search_view_model.dart';
import 'package:flower_app/features/home/presentation/widgets/search/empty_search_view.dart';
import 'package:flower_app/features/home/presentation/widgets/search/init_search_view.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final SearchViewModel _searchViewModel = getIt<SearchViewModel>();
  final TextEditingController _controller = TextEditingController();
  late StreamSubscription _orderSubscription;
  late StreamSubscription _searchSubscription;

  @override
  void initState() {
    super.initState();
    _searchStreamListener();
    _orderStreamListener();
  }

  void _orderStreamListener() {
    _orderSubscription = context.read<OrderViewModel>().uiEventsStream.listen((
      event,
    ) {
      switch (event) {
        case AddToCartEvent():
          if (!mounted) return;
          Toast.showToast(context, "productAddedToCart".tr());
        case UnAuthorizedEvent():
          if (!mounted) return;
          Toast.showAppDialog(context: context, title: event.errorMessage);
      }
    });
  }

  void _searchStreamListener() {
    _searchSubscription = _searchViewModel.uiEventsStream.listen((event) {
      if (!mounted) return;
      switch (event) {
        case OpenProductDetails():
          Navigator.pushNamed(
            context,
            AppRoutes.productDetails,
            arguments: event.product,
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchViewModel,
      child: Scaffold(
        appBar: AppBar(title: Text('search'.tr())),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                context.h(10),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  builder: (context, value, child) {
                    return TextField(
                      onChanged: (value) => _searchViewModel.doIntent(
                        SearchKeywordChanged(value),
                      ),
                      controller: _controller,
                      textInputAction: TextInputAction.search,
                      onTapUpOutside: (_) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 9.5,
                        ),
                        hintText: "home.search".tr(),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _controller.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  _controller.clear();
                                  _searchViewModel.doIntent(SearchCleared());
                                },
                              )
                            : null,
                      ),
                    );
                  },
                ),
                context.h(16),
                Expanded(
                  child: BlocBuilder<SearchViewModel, SearchState>(
                    builder: (context, state) {
                      if (state.searchState.isInitial) {
                        return const InitSearchView();
                      }
                      if (state.searchState.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: context.appTheme.primary,
                          ),
                        );
                      }
                      if (state.searchState.isError) {
                        return AppErrorView(
                          message:
                              state.searchState.errorMessage ??
                              'connectionError'.tr(),
                          onRetry: () {
                            final keyword = _controller.text.trim();
                            if (keyword.isNotEmpty) {
                              _searchViewModel.doIntent(
                                SearchKeywordChanged(keyword),
                              );
                            }
                          },
                        );
                      }
                      final products = state.searchState.data ?? [];

                      if (products.isEmpty) {
                        return const EmptySearchView();
                      }
                      return CustomProductsGridListBuilder(
                        products: products,
                        onProductTap: (product) =>
                            _searchViewModel.doIntent(ProductTapped(product)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchViewModel.close();
    _orderSubscription.cancel();
    _searchSubscription.cancel();
    super.dispose();
  }
}
