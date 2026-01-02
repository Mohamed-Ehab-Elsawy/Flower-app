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
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  isLoggedInUser = await getInitialAppRoute();
  configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      child: const FlowerApp(),
    ),
  );
}

Future<bool> getInitialAppRoute() async {
  final token = await AppLocalStorage.getSecuredString(
    key: LocalKeys.authToken,
  );
  return token.isNotEmpty;
}
