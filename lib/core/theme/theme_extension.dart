import 'package:flutter/material.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  //>>>>>>>>>>>>>>>TextStyles<<<<<<<<<<<<<<<<//
  final TextStyle semiBold24;
  final TextStyle medium20;
  final TextStyle semiBold18;
  final TextStyle medium13;
  final TextStyle medium16;
  final TextStyle regular16;
  final TextStyle regular14;
  final TextStyle regular12;
  final TextStyle semiBold12;
  //>>>>>>>>>>>>>>>Colors<<<<<<<<<<<<<<<<//
  final MaterialColor primary;
  final MaterialColor secondary;
  final MaterialColor surface;
  final Color backgroundColor;
  final Color error;
  final Color success;
  final Color grey;
  final Color lightPink;
  final List<Color> kDefaultRainbowColors;

  AppThemeExtension({
    required this.semiBold24,
    required this.medium20,
    required this.semiBold18,
    required this.medium13,
    required this.medium16,
    required this.regular16,
    required this.regular14,
    required this.regular12,
    required this.semiBold12,
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.backgroundColor,
    required this.error,
    required this.success,
    required this.grey,
    required this.lightPink,
    required this.kDefaultRainbowColors,
  });
  @override
  ThemeExtension<AppThemeExtension> copyWith({
    TextStyle? semiBold2,
    TextStyle? medium20,
    TextStyle? semiBold18,
    TextStyle? medium13,
    TextStyle? medium16,
    TextStyle? regular16,
    TextStyle? regular14,
    TextStyle? regular12,
    TextStyle? semiBold12,
    //>>>>>>>>>>>>>>>Colors<<,<<<<<<<<<<<<<//
    MaterialColor? primary,
    MaterialColor? secondary,
    MaterialColor? surface,
    Color? backgroundColor,
    Color? error,
    Color? success,
    Color? grey,
    Color? lightPink,
    List<Color>? kDefaultRainbowColors,
  }) {
    return AppThemeExtension(
      medium13: medium13 ?? this.medium13,
      semiBold24: semiBold24,
      medium20: medium20 ?? this.medium20,
      semiBold18: semiBold18 ?? this.semiBold18,
      medium16: medium16 ?? this.medium16,
      regular16: regular16 ?? this.regular16,
      regular14: regular14 ?? this.regular14,
      regular12: regular12 ?? this.regular12,
      semiBold12: semiBold12 ?? this.semiBold12,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surface: surface ?? this.surface,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      error: error ?? this.error,
      success: success ?? this.success,
      grey: grey ?? this.grey,
      lightPink: lightPink ?? this.lightPink,
      kDefaultRainbowColors:
          kDefaultRainbowColors ?? this.kDefaultRainbowColors,
    );
  }
  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      semiBold24: TextStyle.lerp(semiBold24, other.semiBold24, t)!,
      medium20: TextStyle.lerp(medium20, other.medium20, t)!,
      semiBold18: TextStyle.lerp(semiBold18, other.semiBold18, t)!,
      medium16: TextStyle.lerp(medium16, other.medium16, t)!,
      medium13: TextStyle.lerp(medium13, other.medium13, t)!,
      regular16: TextStyle.lerp(regular16, other.regular16, t)!,
      regular14: TextStyle.lerp(regular14, other.regular14, t)!,
      regular12: TextStyle.lerp(regular12, other.regular12, t)!,
      semiBold12: TextStyle.lerp(semiBold12, other.semiBold12, t)!,
      primary: _lerpMaterialColor(primary, other.primary, t),
      secondary: _lerpMaterialColor(secondary, other.secondary, t),
      surface: _lerpMaterialColor(surface, other.surface, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      grey: const Color.fromARGB(255, 145, 143, 143),
      lightPink: Color.lerp(lightPink, other.lightPink, t)!,
      kDefaultRainbowColors: <Color>[],
    );
  }
}

// Build a MaterialColor that includes standard Material shade keys (50..900)
// by sampling/interpolating your custom 0..100 palette. Returns a concise
// and predictable map so Flutter can safely look up standard shades.
MaterialColor materialColorWithStandardShades(MaterialColor src) {
  final keys = src.keys.toList()..sort();

  Color sampleAt(double percent) {
    if (keys.isEmpty) return Color(src.toARGB32());
    final lower = keys.lastWhere((k) => k <= percent, orElse: () => keys.first);
    final upper = keys.firstWhere((k) => k >= percent, orElse: () => keys.last);
    final a = src[lower];
    final b = src[upper];
    if (a == null) return b ?? Color(src.toARGB32());
    if (b == null) return a;
    if (lower == upper) return a;
    final t = (percent - lower) / (upper - lower);
    return Color.lerp(a, b, t)!;
  }

  final map = {for (final k in keys) k: src[k]!};
  const standard = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  for (final s in standard) {
    final percent = (s / 900.0) * 100.0; // 50..900 -> 0..100
    map.putIfAbsent(s, () => sampleAt(percent));
  }

  return MaterialColor(src.toARGB32(), map);
}

// Interpolate two MaterialColor instances in a concise way and avoid nulls.
MaterialColor _lerpMaterialColor(MaterialColor a, MaterialColor b, double t) {
  final primary = Color.lerp(Color(a.toARGB32()), Color(b.toARGB32()), t) ??
      Color(a.toARGB32());
  final keys = {...a.keys, ...b.keys}.toList()..sort();
  final map = {for (final k in keys) k: (Color.lerp(a[k], b[k], t) ?? a[k] ?? b[k] ?? primary)};
  return MaterialColor(primary.toARGB32(), map);
}
