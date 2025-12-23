
import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: context.read<AppSectionViewModel>().onTap,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: IAppText.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: IAppText.categories,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: IAppText.cart,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: IAppText.profile,
        ),
      ],
    );
  }
}

