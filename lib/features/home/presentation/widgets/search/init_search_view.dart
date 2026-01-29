import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/constants/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InitSearchView extends StatelessWidget {
  const InitSearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(AppPaths.lottieSearch, width: 220),
        context.h(8),
        Text(
          "Search For Any Product You Want",
          style: context.appTheme.medium16.copyWith(
            fontSize: 14,
            color: context.appTheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}