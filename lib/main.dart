import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/bloc_box/my_bloc_observer.dart';
import 'package:flower_app/flower_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'),],
      path:'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      child: FlowerApp(),
    ),
  );
}
