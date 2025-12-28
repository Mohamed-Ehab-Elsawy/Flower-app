import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app/presentation/widget/custom_card.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/constants/app_dimensions.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_cubit.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_intents.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final ScrollController _scrollController = ScrollController();
  bool _showFilterButton = true;

  @override
  void initState() {
    super.initState();
    context.read<CategoriesViewCubit>().doIntent(GetProductsByCategoryIntent());
    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;

      if (direction == ScrollDirection.reverse && _showFilterButton) {
        setState(() => _showFilterButton = false);
      } else if (direction == ScrollDirection.forward && !_showFilterButton) {
        setState(() => _showFilterButton = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var greyColor = context.appTheme.secondary[70]!;

    return SafeArea(
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: Stack(
          children: [
            BlocBuilder<CategoriesViewCubit, CategoriesViewStates>(
              builder: (context, state) {
                return DefaultTabController(
                  length: state.categories?.length ?? 0,
                  child: Column(
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  color: greyColor,
                                ),
                                hint: Text(
                                  'search',
                                  style: context.appTheme.regular16.copyWith(
                                    color: greyColor,
                                  ),
                                ).tr(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: greyColor,
                                    width: 1,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: greyColor,
                                    width: 1,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              border: BoxBorder.all(color: greyColor, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.filter_list, color: greyColor),
                          ),
                        ],
                      ),
                      context.h(8),
                      TabBar(
                        isScrollable: true,
                        onTap: (index) {
                          context.read<CategoriesViewCubit>().doIntent(
                            GetProductsByCategoryIntent(
                              categoryId: state.categories?[index],
                            ),
                          );
                        },
                        tabs:
                            state.categories
                                ?.map((category) => Tab(text: category))
                                .toList() ??
                            [],
                      ),
                      context.h(8),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                          physics: const BouncingScrollPhysics(),
                          controller: _scrollController,
                          itemCount: state.productsStates?.data?.length ?? 0,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomCard(
                              imageUrl:
                                  state
                                      .productsStates
                                      ?.data?[index]
                                      .imgCover ??
                                  "",
                              title:
                                  state.productsStates?.data?[index].title ??
                                  "",
                              price:
                                  state
                                      .productsStates
                                      ?.data?[index]
                                      .priceAfterDiscount
                                      ?.toDouble() ??
                                  0.0,
                              oldPrice:
                                  state.productsStates?.data?[index].price
                                      ?.toDouble() ??
                                  0.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
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

  Widget _filterButton() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: context.appTheme.primary,
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            const Icon(Icons.tune, color: Colors.white),
            Text(
              'Filter',
              style: context.appTheme.medium16.copyWith(color: Colors.white),
            ).tr(),
          ],
        ),
      ),
    ),
  );
}
