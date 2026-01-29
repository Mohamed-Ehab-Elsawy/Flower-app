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
      final buffer = StringBuffer();
      if (length == 6 || length == 7) {
        buffer.write('ff');
      }
      buffer.write(replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
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
