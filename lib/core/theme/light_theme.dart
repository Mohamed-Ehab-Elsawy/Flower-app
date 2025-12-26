import 'package:flower_app/core/styles/app_textstyles.dart';
import 'package:flower_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LightTheme extends AppTheme {
  @override
  BottomNavigationBarThemeData get bottomAppBarThemeData =>
      BottomNavigationBarThemeData(
        selectedItemColor: color.primary,
        unselectedItemColor: color.secondary[80],
        backgroundColor: color.secondary[60],
      );

  @override
  AppColors get color => LightColors();

  @override
  ThemeData get themeData => ThemeData(
    brightness: Brightness.light,
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(color.secondary),
      trackColor: WidgetStateProperty.all(color.primary),
    ),
    useMaterial3: true,
    filledButtonTheme: filledButtonThemeData,
    inputDecorationTheme: inputDecorationTheme,
    elevatedButtonTheme: elevatedButtonThemeData,
    bottomNavigationBarTheme: bottomAppBarThemeData,
    scaffoldBackgroundColor: color.backgroundColor,
    outlinedButtonTheme: outlinedButtonThemeData,
    checkboxTheme: checkboxThemeData,
    colorScheme: colorScheme,
    textTheme: textTheme,
  );

  @override
  ElevatedButtonThemeData get elevatedButtonThemeData =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: color.surface[30],
          disabledForegroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          backgroundColor: color.primary,
          foregroundColor: color.secondary,

          textStyle: textTheme.titleMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );

  @override
  OutlinedButtonThemeData get outlinedButtonThemeData =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          side: BorderSide(color: color.grey, width: 2),
          foregroundColor: color.grey,
          textStyle: textTheme.titleMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: color.grey),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: color.error),
    ),
    labelStyle: TextStyle(color: color.grey),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: color.grey),
    ),

    hintStyle: textTheme.bodyMedium?.copyWith(color: color.secondary[70]),
  );

  @override
  CheckboxThemeData get checkboxThemeData => CheckboxThemeData(
    side: BorderSide(color: color.grey, width: 2),
    checkColor: WidgetStateProperty.all(color.secondary),
  );

  @override
  FilledButtonThemeData get filledButtonThemeData => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: color.primary,
      foregroundColor: color.secondary,
      textStyle: textTheme.titleMedium,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ),
  );

  @override
  ColorScheme get colorScheme => ColorScheme.fromSeed(
    primary: color.primary,
    seedColor: color.primary,
    onPrimaryContainer: color.lightPink,
    error: color.error,
    surface: color.backgroundColor,
    secondary: color.secondary,
    onSurface: color.surface,
    onTertiary: color.grey,
    tertiary: color.success,
  );

  @override
  TextTheme get textTheme => TextTheme(
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
    labelMedium: AppTextStyles.labelMedium,
  );
  @override
  TextFormField get textFormField => TextFormField(
    style: textTheme.bodyMedium,
    cursorColor: Color(0xFF535353),
    decoration: InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.all(16),
      hintStyle: textTheme.bodyMedium?.copyWith(color: Color(0xFF535353)),
      labelStyle: textTheme.bodyMedium?.copyWith(color: Color(0xFF535353)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Color(0xFF535353), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Color(0xFF535353), width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Color(0xFF535353), width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Color(0xFFCC1010), width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Color(0xFFCC1010), width: 1),
      ),
    ),
  );
  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    centerTitle: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: textTheme.headlineMedium,
    actionsIconTheme: IconThemeData(size: 20, color: Colors.black),
  );
}

class LightColors extends AppColors {
  @override
  Color get backgroundColor => Colors.white;

  @override
  Color get error => const Color(0xFFCC1010);

  @override
  MaterialColor get primary => const MaterialColor(0xFFD21E6A, <int, Color>{
    10: Color(0xFFf6d2e1),
    20: Color(0xFFf0b4cd),
    30: Color(0xFFe98fb5),
    40: Color(0xFFe1699c),
    50: Color(0xFFda4483),
    60: Color(0xFFaf1958),
    70: Color(0xFF8c1447),
    80: Color(0xFF690f35),
    90: Color(0xFF460a23),
    100: Color(0xFF2a0615),
  });

  @override
  MaterialColor get secondary => const MaterialColor(0xFFf9f9f9, <int, Color>{
    10: Color(0xFFfefefe),
    20: Color(0xFFfdfdfd),
    30: Color(0xFFfcfcfc),
    40: Color(0xFFfbfbfb),
    50: Color(0xFFfafafa),
    60: Color(0xFFd0d0d0),
    70: Color(0xFFa6a6a6),
    80: Color(0xFF7D7D7D),
    90: Color(0xFF535353),
    100: Color(0xFF323232),
  });

  @override
  Color get success => const Color(0xFF0CB359);

  @override
  MaterialColor get surface => const MaterialColor(0xFF0c1015, <int, Color>{
    10: Color(0xFFcecfd0),
    20: Color(0xFFaeafb1),
    30: Color(0xFF86888a),
    40: Color(0xFF5d6063),
    50: Color(0xFF34383c),
    60: Color(0xFF0a0d12),
    70: Color(0xFF080b0e),
    80: Color(0xFF06080b),
    90: Color(0xFF040507),
    100: Color(0xFF020304),
  });

  @override
  Color get grey => const Color(0xFF535353);

  @override
  Color get lightPink => const Color(0xFFF9ECF0);
}
