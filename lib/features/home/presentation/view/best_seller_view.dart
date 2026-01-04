import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app/presentation/widget/custom_card.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/features/home/presentation/cubit/best_seller_state.dart';
import 'package:flower_app/features/home/presentation/cubit/best_seller_view_model.dart';
import 'package:flower_app/features/home/presentation/widgets/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellerView extends StatefulWidget {
  const BestSellerView({super.key});

  @override
  State<BestSellerView> createState() => _BestSellerViewState();
}

class _BestSellerViewState extends State<BestSellerView> {
  late BestSellerViewModel _bestSellerViewModel;

  @override
  void initState() {
    _bestSellerViewModel = getIt.get<BestSellerViewModel>()
      ..uiEventsStream.listen((event) {
        switch (event) {
          case GetBestSellerIntent():
            GetBestSellerIntent();
          case NavigateToProductDetailsIntent():
            if (!mounted) return;
            Navigator.pushNamed(
              context,
              AppRoutes.productDetails,
              arguments: event.productId,
            );
          case NavigateToHomeIntent():
            if (!mounted) return;
            Navigator.pop(context);
          case AddToCartIntent():
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BestSellerViewModel>(
      create: (context) =>
          getIt.get<BestSellerViewModel>()..doIntent(GetBestSellerIntent()),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
          titleSpacing: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: () =>
                _bestSellerViewModel.doIntent(NavigateToHomeIntent()),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: context.appTheme.surface,
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
              final items = state.bestSellerState.data ?? [];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
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
                    return InkWell(
                      onTap: () {
                        _bestSellerViewModel.doIntent(
                          NavigateToProductDetailsIntent(productId: item),
                        );
                      },
                      child: CustomCard(product: item),
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
