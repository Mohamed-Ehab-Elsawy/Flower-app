import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/app_local_storage.dart';
import 'package:flower_app/core/helper/local_keys.dart';
import 'package:flower_app/flower_app.dart';
import 'package:flutter/material.dart';

bool isLoggedInUser = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  isLoggedInUser = await getInitialAppRoute();
  configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      child:const FlowerApp(),
    ),
  );
}

Future<bool> getInitialAppRoute() async {
  final rememberMe = await AppLocalStorage.getBool(LocalKeys.rememberMe);
  final token = await AppLocalStorage.getSecuredString(key: LocalKeys.authToken);
  return rememberMe && token.isNotEmpty;
}