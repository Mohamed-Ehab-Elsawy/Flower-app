import 'package:flutter/material.dart';

abstract class AppColors {
  MaterialColor get primary;
  MaterialColor get secondary;
  MaterialColor get surface;
  Color get backgroundColor;
  Color get error;
  Color get success;
  Color get grey;
  Color get lightPink;
}

abstract class AppTheme {
  AppColors get color;
  TextTheme get textTheme;
  FilledButtonThemeData get filledButtonThemeData;
  ThemeData get themeData;
  OutlinedButtonThemeData get outlinedButtonThemeData;
  BottomNavigationBarThemeData get bottomAppBarThemeData;
  ElevatedButtonThemeData get elevatedButtonThemeData;
  InputDecorationTheme get inputDecorationTheme;
  CheckboxThemeData get checkboxThemeData;
  ColorScheme get colorScheme;
  AppBarTheme get appBarTheme;
  TextFormField get textFormField;
}
