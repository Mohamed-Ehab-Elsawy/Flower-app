import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/home/presentation/view_model/home_state.dart';
import 'package:flower_app/features/home/presentation/view_model/home_view_model.dart';
import 'package:flower_app/features/home/presentation/widgets/seaction_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeViewModel>();
    List<ProductTypeEntity>? categories = [];
    return Column(
      children: [
        SectionHeader(
          title: "home.categories",
          onPressed: () =>
              cubit.doEvent(ViewAllCategoriesEvent(categories: categories)),
        ),
        BlocBuilder<HomeViewModel, HomeState>(
          buildWhen: (previous, current) =>
              previous.homeState.data?.categories !=
              current.homeState.data?.categories,
          builder: (context, state) {
            switch (state.homeState.requestState) {
              case RequestState.init:
              case RequestState.loading:
                return _buildDummyCategoriesList(state);
              case RequestState.loaded:
                categories = state.homeState.data?.categories;
                return _buildCategoriesList(categories?.take(5).toList());
              case RequestState.error:
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    ).toSliverBoxAdapter;
  }

  Widget _buildDummyCategoriesList(HomeState state) {
    final categories = List.generate(
      5,
      (index) => const ProductTypeEntity(
        name: "XXXXXXX",
        image: 'https://picsum.photos/600',
      ),
    );
    return SizedBox(
      height: 110,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 16),
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => Skeletonizer(
          enabled: state.homeState.isLoading,
          child: CategoryItem(category: categories[index]),
        ),
      ),
    );
  }

  Widget _buildCategoriesList(List<ProductTypeEntity>? categories) {
    return SizedBox(
      height: 95,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 16),
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories?.length ?? 0,
        itemBuilder: (context, index) =>
            CategoryItem(category: categories?[index]),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final ProductTypeEntity? category;

  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;
    return Column(
      spacing: 8,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
          decoration: BoxDecoration(
            color: theme.lightPink,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: category?.image ?? "",
            height: 24,
            width: 24,
            fit: BoxFit.cover,
            placeholder: (context, url) => const SizedBox.shrink(),
            errorWidget: (context, url, error) => const SizedBox.shrink(),
          ),
        ),
        Text(category?.name ?? "", style: theme.regular14),
      ],
    );
  }
}
