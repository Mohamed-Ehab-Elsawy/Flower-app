import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/home/presentation/view_model/home_state.dart';
import 'package:flower_app/features/home/presentation/view_model/home_view_model.dart';
import 'package:flower_app/features/home/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OccasionList extends StatelessWidget {
  const OccasionList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeViewModel>();
    List<ProductTypeEntity>? occasions = [];
    return Column(
      children: [
        SectionHeader(
          title: "home.occasion",
          onPressed: () =>
              cubit.doEvent(ViewAllOccasionsEvent(occasions: occasions)),
        ),
        BlocBuilder<HomeViewModel, HomeState>(
          buildWhen: (previous, current) =>
              previous.homeState.data?.occasions !=
              current.homeState.data?.occasions,
          builder: (context, state) {
            switch (state.homeState.requestState) {
              case RequestState.init:
              case RequestState.loading:
                return _buildDummyOccasionList(state);
              case RequestState.loaded:
                occasions = state.homeState.data!.occasions;
                return _buildOccasionList(occasions);
              case RequestState.error:
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    ).toSliverBoxAdapter;
  }

  Widget _buildOccasionList(List<ProductTypeEntity>? occasions) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: occasions?.length ?? 0,
        itemBuilder: (context, index) =>
            OccasionItem(occasion: occasions?[index]),
      ),
    );
  }

 Widget _buildDummyOccasionList(HomeState state) {
    final occasions = List.generate(
      5,
      (index) => const ProductTypeEntity(
        name: "XXXXXXX",
        image: 'https://picsum.photos/600',
      ),
    );
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => Skeletonizer(
          enabled: state.homeState.isLoading,
          child: OccasionItem(occasion: occasions[index]),
        ),
      ),
    );
  }
}

class OccasionItem extends StatelessWidget {
  const OccasionItem({super.key, required this.occasion});

  final ProductTypeEntity? occasion;

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
            imageUrl: occasion?.image ?? "",
            height: 151,
            width: 131,
            fit: BoxFit.fill,
          ),
          context.h(8),
          Text(
            occasion?.name ?? "",
            style: theme.medium13.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
