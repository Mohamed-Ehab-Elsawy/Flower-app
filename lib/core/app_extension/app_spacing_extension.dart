import 'package:flutter/material.dart';

extension AppSpacingExtensionWithContext on BuildContext {
  double get _screenH => MediaQuery.of(this).size.height;
  double get _screenW => MediaQuery.of(this).size.width;

  Widget h(double h) => SizedBox(height: _screenH * (h / 812));
  Widget w(double w) => SizedBox(width: _screenW * (w / 375));
}
