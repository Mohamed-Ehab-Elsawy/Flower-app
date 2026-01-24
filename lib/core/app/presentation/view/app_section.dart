import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app/presentation/view_model/app_section_contracts.dart';
import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:flower_app/core/app/presentation/widget/bottom_nav_bar.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/orders/presentation/view/order_view.dart';
import 'package:flower_app/features/categories/presentation/view/categories_view.dart';
import 'package:flower_app/features/home/presentation/view/home_view.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/main_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  @override
  void initState() {
    super.initState();
    context.read<AppSectionViewModel>().uiStream.listen((event) {
      if (event is AppSectionLogoutEvent && mounted) {
        Toast.showToast(context, "invalid_token".tr(), isError: true);
        // Navigator.pushNamedAndRemoveUntil(
        //   context,
        //   AppRoutes.login,
        //   (_) => false,
        // );
      }
    });
  }

  List<Widget> get pages => [
    const HomeView(),
    BlocBuilder<AppSectionViewModel, AppSectionState>(
      builder: (context, state) =>
          CategoriesView(index: state.selectedCategoryIndex),
    ),
    const OrderView(),
    const MainProfileView(),
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
