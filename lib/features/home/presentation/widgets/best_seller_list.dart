import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/app/domain/entities/product_entity.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/home/presentation/view_model/home_state.dart';
import 'package:flower_app/features/home/presentation/view_model/home_view_model.dart';
import 'package:flower_app/features/home/presentation/widgets/seaction_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestSellerList extends StatelessWidget {
  const BestSellerList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeViewModel>();
    List<ProductEntity>? bestSeller = [];
    return Column(
      children: [
        SectionHeader(
          title: "home.best_seller",
          onPressed: () =>
              cubit.doEvent(ViewAllBestSellerEvent(bestSeller: bestSeller)),
        ),
        BlocBuilder<HomeViewModel, HomeState>(
          buildWhen: (previous, current) =>
              previous.homeState.data?.bestSeller !=
              current.homeState.data?.bestSeller,
          builder: (context, state) {
            switch (state.homeState.requestState) {
              case RequestState.init:
              case RequestState.loading:
                return _buildDummyBestSellerList(state);
              case RequestState.loaded:
                bestSeller = state.homeState.data?.bestSeller;
                return _buildBestSellerList(bestSeller?.take(5).toList());
              case RequestState.error:
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    ).toSliverBoxAdapter;
  }

  Widget _buildBestSellerList(List<ProductEntity>? bestSeller) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),

        scrollDirection: Axis.horizontal,
        itemCount: bestSeller?.length ?? 0,
        itemBuilder: (context, index) =>
            BestSellerItem(product: bestSeller?[index]),
      ),
    );
  }
}

Widget _buildDummyBestSellerList(HomeState state) {
  final bestSeller = List.generate(
    5,
    (index) => const ProductEntity(
      title: "XXXXXXX",
      imageCover: 'https://picsum.photos/600',
    ),
  );
  return SizedBox(
    height: 200,
    child: ListView.separated(
      padding: const EdgeInsets.only(left: 16),
      separatorBuilder: (context, index) => context.w(16),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) => Skeletonizer(
        enabled: state.homeState.isLoading,
        child: BestSellerItem(product: bestSeller[index]),
      ),
    ),
  );
}

class BestSellerItem extends StatelessWidget {
  const BestSellerItem({super.key, required this.product});

  final ProductEntity? product;

  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 131,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: product?.imageCover ?? "",
            height: 151,
            width: 131,
            fit: BoxFit.fill,
          ),
          context.h(8),
          Text(
            product?.title ?? "",
            style: theme.regular12.copyWith(overflow: TextOverflow.ellipsis),
          ),
          Text(
            "${product?.price.toString()} EGP",
            style: theme.medium13.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
