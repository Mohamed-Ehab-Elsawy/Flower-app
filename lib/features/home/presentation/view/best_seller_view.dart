import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app/presentation/widget/custom_card.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/features/home/presentation/cubit/best_seller_state.dart';
import 'package:flower_app/features/home/presentation/cubit/best_seller_view_model.dart';
import 'package:flower_app/features/home/presentation/widgets/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellerView extends StatelessWidget {
  const BestSellerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BestSellerViewModel>(
      create: (context) =>
          getIt.get<BestSellerViewModel>()..doIntent(GetBestSellerIntent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("mostSelling".tr(), style: context.appTheme.medium20),
              Text(
                "Bloom with our exquisite best sellers".tr(),
                style: context.appTheme.medium13.copyWith(
                  color: context.appTheme.surface[40],
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<BestSellerViewModel, BestSellerState>(
          builder: (context, state) {
            if (state.bestSellerState.requestState == RequestState.loading) {
              return const LoadingList();
            } else if (state.bestSellerState.requestState ==
                RequestState.error) {
              return Center(
                child: Text(
                  state.bestSellerState.errorMessage ?? "An error occurred",
                ),
              );
            } else if (state.bestSellerState.requestState ==
                RequestState.loaded) {
              final items =
                  state.bestSellerState.data?.bestSellerItemEntityList ?? [];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.53,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return CustomCard(
                      title: item.title ?? "",
                      imageUrl: item.imgCover ?? "",

                      onTap: () {},
                      price: item.priceAfterDiscount?.toDouble() ?? 0,
                      oldPrice: item.price?.toDouble(),
                      discountPercentage: item.discountPercentage?.toInt(),
                    );
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
