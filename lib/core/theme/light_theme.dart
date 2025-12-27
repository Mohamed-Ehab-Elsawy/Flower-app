import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flower_app/core/styles/app_textstyles.dart';
import 'package:flower_app/core/theme/app_theme.dart';
import 'package:flower_app/core/theme/theme_extension.dart';
import 'package:flutter/material.dart';

class LightTheme extends AppTheme {
  @override
  BottomNavigationBarThemeData get bottomAppBarThemeData =>
      BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: textTheme.bodySmall,
        selectedLabelStyle: textTheme.bodySmall,
        selectedItemColor: color.primary,
        unselectedItemColor: color.secondary[80],
        backgroundColor: color.secondary,
      );

  @override
  AppColors get color => _LightColors();

  @override
  ThemeData get themeData => ThemeData(
    brightness: Brightness.light,

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(color.secondary),
      trackColor: WidgetStateProperty.all(color.primary),
    ),
    fontFamily: IAppText.fontFamily,
    useMaterial3: true,
    filledButtonTheme: filledButtonThemeData,
    inputDecorationTheme: inputDecorationTheme,
    elevatedButtonTheme: elevatedButtonThemeData,
    bottomNavigationBarTheme: bottomAppBarThemeData,
    scaffoldBackgroundColor: color.backgroundColor,
    outlinedButtonTheme: outlinedButtonThemeData,
    checkboxTheme: checkboxThemeData,
    extensions: [appThemeExtension],
    primarySwatch: materialColorWithStandardShades(color.primary),
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
          textStyle: appThemeExtension.medium16,
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
          textStyle: appThemeExtension.medium16,
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

    hintStyle: appThemeExtension.medium16.copyWith(color: color.secondary[70]),
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
      textStyle: appThemeExtension.medium16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ),
  );

  @override
  AppThemeExtension get appThemeExtension => AppThemeExtension(
    semiBold24: AppTextStyles.semiBold24,
    medium20: AppTextStyles.medium20,
    semiBold18: AppTextStyles.semiBold18,
    medium16: AppTextStyles.medium16,
    regular16: AppTextStyles.regular16,
    regular14: AppTextStyles.regular14,
    regular12: AppTextStyles.regular12,
    semiBold12: AppTextStyles.semiBold12,
    primary: color.primary,
    secondary: color.secondary,
    surface: color.surface,
    backgroundColor: color.backgroundColor,
    error: color.error,
    success: color.success,
    grey: color.grey,
    lightPink: color.lightPink,
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

class _LightColors extends AppColors {
  @override
  Color get backgroundColor => Colors.white;

  @override
  Color get error => const Color(0xFFCC1010);

  @override
  MaterialColor get primary => MaterialColor(0xFFD21E6A, <int, Color>{
    0: Color(0xFFD21E6A),
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
  MaterialColor get secondary => MaterialColor(0xFFf9f9f9, <int, Color>{
    0: Color(0xFFf9f9f9),
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
  MaterialColor get surface => MaterialColor(0xFF0c1015, <int, Color>{
    0: Color(0xFF0c1015),
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
  Color get lightPink => Color(0xFFF9ECF0);

  @override
  Color get textColor => Colors.black;
}
