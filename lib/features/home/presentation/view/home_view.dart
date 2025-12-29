import 'dart:developer';

import 'package:flower_app/core/app_extension/app_extension.dart';
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
  void didChangeDependencies() {
    context.read<HomeViewModel>().uiEventsStream.listen((event) {
      switch (event) {
        case ViewAllCategoriesEvent():
          log("ViewAllCategoriesEvent");
          //context.pushName(routeName);
        case ViewAllBestSellerEvent():
          log("ViewAllBestSellerEvent");
          //context.pushName(routeName);
        case ViewAllOccasionsEvent():
          log("ViewAllOccasionsEvent");
          //context.pushName(routeName);
      }
    });
    super.didChangeDependencies();
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
