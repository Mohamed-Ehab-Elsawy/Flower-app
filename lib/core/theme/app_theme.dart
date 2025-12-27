import 'package:flower_app/core/theme/theme_extension.dart';
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
  Color get textColor;
}

abstract class AppTheme {
  AppColors get color;
  AppThemeExtension get appThemeExtension;
  FilledButtonThemeData get filledButtonThemeData;
  ThemeData get themeData;
  OutlinedButtonThemeData get outlinedButtonThemeData;
  BottomNavigationBarThemeData get bottomAppBarThemeData;
  ElevatedButtonThemeData get elevatedButtonThemeData;
  InputDecorationTheme get inputDecorationTheme;
  CheckboxThemeData get checkboxThemeData;
  AppBarTheme get appBarTheme;
  
}
