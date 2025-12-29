import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/bloc_box/my_bloc_observer.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/app_local_storage.dart';
import 'package:flower_app/core/helper/local_keys.dart';
import 'package:flower_app/flower_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool isLoggedInUser = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   configureDependencies();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  isLoggedInUser = await getInitialAppRoute();
 

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