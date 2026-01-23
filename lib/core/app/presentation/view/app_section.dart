import 'package:flower_app/core/app/presentation/view_model/app_section_contracts.dart';
import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:flower_app/core/app/presentation/widget/bottom_nav_bar.dart';
import 'package:flower_app/features/orders/presentation/view/order_view.dart';
import 'package:flower_app/features/categories/presentation/view/categories_view.dart';
import 'package:flower_app/features/home/presentation/view/home_view.dart';
import 'package:flower_app/features/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  List<Widget> get pages => [
    const HomeView(),
    BlocBuilder<AppSectionViewModel, AppSectionState>(
      builder: (context, state) =>
          CategoriesView(index: state.selectedCategoryIndex),
    ),
    const OrderView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSectionViewModel, AppSectionState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.currentTab],
          bottomNavigationBar: BottomNavBar(
            currentIndex: state.currentTab,
            onTap: (index) => _onTap(index, state),
          ),
        );
      },
    );
  }

  _onTap(int index, AppSectionState state) {
    context.read<AppSectionViewModel>().doIntent(switch (index) {
      0 => ViewHomeIntent(),
      1 => ViewCategoryIntent(state.selectedCategoryIndex),
      2 => ViewCartIntent(),
      _ => ViewProfileIntent(),
    });
  }
}
