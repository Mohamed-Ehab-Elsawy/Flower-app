import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/flower_app.dart';
import 'package:flutter/material.dart';

import 'core/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      child: FlowerApp(),
    ),
  );
}
