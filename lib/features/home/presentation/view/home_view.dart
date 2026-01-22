import 'package:flower_app/core/app/presentation/view_model/app_section_contracts.dart';
import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/features/home/presentation/view_model/home_view_model.dart';
import 'package:flower_app/features/home/presentation/widgets/best_seller_list.dart';
import 'package:flower_app/features/home/presentation/widgets/categories_list.dart';
import 'package:flower_app/features/home/presentation/widgets/logo_search.dart';
import 'package:flower_app/features/home/presentation/widgets/occasion_list.dart';
import 'package:flower_app/features/home/presentation/widgets/user_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().uiEventsStream.listen((event) {
      switch (event) {
        case ViewAllOccasionsEvent():
          if (!mounted) return;
          Navigator.of(
            context,
          ).pushNamed(AppRoutes.occasion, arguments: event.occasions ?? []);
        case ItemBestSellerSelectedEvent():
          if (!mounted) return;
          Navigator.of(
            context,
          ).pushNamed(AppRoutes.productDetails, arguments: event.product);
        case ViewAllBestSellerEvent():
          if (!mounted) return;
          Navigator.of(context).pushNamed(AppRoutes.mostSelling);
        case ViewAllCategoriesEvent():
          if (!mounted) return;
          context.read<AppSectionViewModel>().doIntent(
            ViewCategoryIntent(event.index),
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: CustomScrollView(
        slivers: [
          LogoAndSearch(),
          UserAddress(),
          CategoryList(),
          BestSellerList(),
          OccasionList(),
        ],
      ),
    );
  }
}
