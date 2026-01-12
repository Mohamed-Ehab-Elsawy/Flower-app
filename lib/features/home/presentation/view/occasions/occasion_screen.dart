import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flower_app/core/app/presentation/widget/custom_card.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_cubit.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_events.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_states.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart'
    show LoadingIndicator, Indicator;

class OccasionScreen extends StatefulWidget {
  const OccasionScreen({super.key});

  @override
  State<OccasionScreen> createState() => _OccasionScreenState();
}

class _OccasionScreenState extends State<OccasionScreen> {
  final occasionsCubit = getIt.get<OccasionsCubit>();

  late List<ProductTypeEntity> occasions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is List<ProductTypeEntity>) {
      occasions = args;
    } else {
      occasions = [];
    }
  }

  @override
  void initState() {
    super.initState();
    occasionsCubit.occasionsUiEvent.listen((event) {
      switch (event) {
        case NavigateToProductDetails():
          {
            Navigator.pushNamed(
              context,
              "/productDetails",
              arguments: event.product,
            );
          }
      }
    });
    context.read<OrderViewModel>().uiEventsStream.listen((event) {
      switch (event) {
        case AddToCartEvent():
          //show toast
          if (!mounted) return;
          Toast.showToast(context, "Product added to cart");
        case UnAuthorizedEvent():
          if (!mounted) return;
          Toast.shodDialog(context: context, title: event.errorMessage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OccasionsCubit>(
      create: (context) {
        final cubit = occasionsCubit;
        if (occasions.isNotEmpty) {
          cubit.doIntent(
            GetAllProductsByOccasionsEvents(occasionId: occasions.first.id!),
          );
        }
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Occasion").tr(),
              Text(
                "Bloom with our exquisite best sellers",
                style: context.appTheme.regular16,
              ).tr(),
            ],
          ),
        ),
        body: Column(
          children: [
            DefaultTabController(
              length: occasions.length,
              child: Builder(
                builder: (context) {
                  return TabBar(
                    isScrollable: true,
                    // indicator: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                    // labelColor: context.appTheme.primary,
                    // unselectedLabelColor: Colors.grey,
                    //// indicatorSize: TabBarIndicatorSize.tab,
                    //  indicatorColor: context.appTheme.primary,
                    //dividerColor: context.appTheme.primary,
                    // indicatorPadding: const EdgeInsets.symmetric(
                    //   horizontal: 2,
                    //   vertical: 2,
                    // ),
                    tabs: occasions
                        .map(
                          (occasions) => Tab(
                            child: Text(
                              occasions.name ?? "untitled".tr(),
                              style: context.appTheme.regular16,
                            ),
                          ),
                        )
                        .toList(),
                    onTap: (index) {
                      final selectedOccasion = occasions[index];
                      context.read<OccasionsCubit>().doIntent(
                        GetAllProductsByOccasionsEvents(
                          occasionId: selectedOccasion.id!,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            BlocBuilder<OccasionsCubit, OccasionsStates>(
              builder: (context, state) {
                if (state.productsState?.errorMessage != null &&
                    state.productsState!.errorMessage!.isNotEmpty) {
                  return Text(state.productsState!.errorMessage!);
                } else if (!(state.productsState?.isLoading ?? false) &&
                    state.productsState?.data != null &&
                    state.productsState!.data!.isNotEmpty) {
                  final products = state.productsState?.data ?? [];
                  if (products.isEmpty) {
                    return Center(
                      child: Text(
                        "There is no products yet",
                        style: context.appTheme.medium20,
                      ).tr(),
                    );
                  }
                  return Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 250,
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final products = state.productsState?.data ?? [];

                        final product = products[index];
                        return InkWell(
                          onTap: () {
                            occasionsCubit.doEvent(
                              NavigateToProductDetails(product: product),
                            );
                          },
                          child: CustomCard(
                            product: product,
                            onTap: product.outOfStock
                                ? null
                                : () {
                                    context.read<OrderViewModel>().doIntent(
                                      AddItemToCart(product: product),
                                    );
                                  },
                          ),
                        );
                      },
                      itemCount: state.productsState!.data!.length,
                    ),
                  );
                } else if (!(state.productsState?.isLoading ?? false) &&
                    state.productsState?.data != null &&
                    state.productsState!.data!.isEmpty) {
                  return Text(
                    "There is no products yet",
                    style: context.appTheme.medium20,
                  ).tr();
                } else {
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: LoadingIndicator(
                            indicatorType: Indicator.lineScale,
                            colors: context.appTheme.kDefaultRainbowColors,
                            strokeWidth: 1,
                            backgroundColor: context.appTheme.backgroundColor,
                            pathBackgroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
