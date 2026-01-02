import 'dart:developer';
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
          log(event.categories?[0].name.toString() ?? "No Data");
        //context.pushName(routeName);
        case ViewAllBestSellerEvent():
          
        //context.pushName(routeName);
        case ViewAllOccasionsEvent():
          //  log(event.occasions?[0].name.toString() ?? "No Data");
        //context.pushName(routeName);
        case ItemBestSellerSelectedEvent():
          // context.pushName(details,event.product)
         
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
