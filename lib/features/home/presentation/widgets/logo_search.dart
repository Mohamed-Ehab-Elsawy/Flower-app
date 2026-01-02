import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/constants/app_paths.dart';
import 'package:flutter/material.dart';

class LogoAndSearch extends StatelessWidget {
  const LogoAndSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: Column(
        children: [
          context.h(16),
          SizedBox(
            height: 36,
            child: Row(
              spacing: 17,
              children: [
                Image.asset(AppPaths.logo),
                Expanded(
                  child: TextField(
                    onTapUpOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 9.5,
                      ),
                      hintText: "home.search".tr(),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
          context.h(16),
        ],
      ).toSliverBoxAdapter,
    );
  }
}
