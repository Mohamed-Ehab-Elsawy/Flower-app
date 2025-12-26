import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/flower_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'),],
      path:'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      child:const FlowerApp(),
    ),
  );
}
