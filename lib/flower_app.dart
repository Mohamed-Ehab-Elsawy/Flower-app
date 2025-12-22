import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flutter/material.dart';

class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: IAppText.appName,
      debugShowCheckedModeBanner: false,
      theme: LightTheme().themeData,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: AppRoutes.signup,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
