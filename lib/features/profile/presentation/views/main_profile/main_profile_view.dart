import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/localization/view/language_bottom_sheet.dart';
import 'package:flutter/material.dart';

class MainProfileView extends StatefulWidget {
  const MainProfileView({super.key});

  @override
  State<MainProfileView> createState() => _MainProfileViewState();
}

class _MainProfileViewState extends State<MainProfileView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  showLanguageBottomSheet() {
    showModalBottomSheet(
      backgroundColor: const Color(0xFFF9F9F9),
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      showDragHandle: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          color: context.appTheme.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: const LanguageBottomSheet(),
      ),
    );

    setState(() {});
  }
}
