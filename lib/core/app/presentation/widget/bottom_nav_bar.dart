import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          label: 'navigation.home'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.category_outlined),
          label: 'navigation.categories'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart_outlined),
          label: 'navigation.cart'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          label: 'navigation.profile'.tr(),
        ),
      ],
    );
  }
}
