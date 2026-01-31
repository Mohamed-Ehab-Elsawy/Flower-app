import 'package:flower_app/core/theme/theme_extension.dart';
import 'package:flutter/material.dart';

extension AppNavigatorExtension on BuildContext {
  void pushName(String routeName) => Navigator.of(this).pushNamed(routeName);

  void pop() => Navigator.of(this).pop();

  void pushNamedAndRemoveUntil(String routeName) {
    Navigator.of(this).pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  void pushReplacement(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);

  AppThemeExtension get appTheme {
    final ext = Theme.of(this).extension<AppThemeExtension>();
    if (ext == null) {
      throw FlutterError(
        'AppThemeExtension not found in ThemeData.extensions. Make sure you add AppThemeExtension to your ThemeData (e.g., ThemeData(extensions: [appThemeExtension]))',
      );
    }
    return ext;
  }
}

extension OnSliver on Widget {
  SliverToBoxAdapter get toSliverBoxAdapter => SliverToBoxAdapter(child: this);
}

extension ServerDrivenUtils on String {
  Color get toColor {
    try {
      var hex = trim();

      if (hex.startsWith('#')) {
        hex = hex.substring(1);
      } else if (hex.toLowerCase().startsWith('0x')) {
        hex = hex.substring(2);
      }

      if (hex.length == 6) {
        hex = 'FF$hex';
      }
      if (hex.length != 8) {
        throw const FormatException('Invalid hex color length');
      }

      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return Colors.black;
    }
  }

  FontWeight get toFontWeight {
    switch (toLowerCase()) {
      case 'bold':
        return FontWeight.bold;
      case 'w500':
      case 'medium':
        return FontWeight.w500;
      case 'w300':
      case 'light':
        return FontWeight.w300;
      default:
        return FontWeight.normal;
    }
  }
}
