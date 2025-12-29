import 'package:flower_app/core/theme/theme_extension.dart';
import 'package:flutter/material.dart';

extension AppNavigatorExtension on BuildContext {
  void pushName(String routeName) => Navigator.of(this).pushNamed(routeName);

  void pop() => Navigator.of(this).pop();

  void pushReplacement(String routeName) =>
      Navigator.of(this).pushReplacementNamed(routeName);

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
