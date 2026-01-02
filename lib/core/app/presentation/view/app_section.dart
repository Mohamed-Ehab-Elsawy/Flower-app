import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:flower_app/core/app/presentation/widget/bottom_nav_bar.dart';
import 'package:flower_app/features/cart/presentation/view/cart_view.dart';
import 'package:flower_app/features/categories/presentation/view/categories_view.dart';
import 'package:flower_app/features/home/presentation/view/home_view.dart';
import 'package:flower_app/features/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSection extends StatelessWidget {
  const AppSection({super.key});

  List<Widget> get pages => const [
    HomeView(),
    CategoriesView(),
    CartView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    int currentTab = context.watch<AppSectionViewModel>().state;
    return Scaffold(
      body: pages[currentTab],
      bottomNavigationBar: BottomNavBar(currentIndex: currentTab),
    );
  }
}
