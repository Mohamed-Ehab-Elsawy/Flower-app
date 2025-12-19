import 'package:flutter/material.dart';

extension AppNavigatorExtension on BuildContext {
  void pushName(String routeName) => Navigator.of(this).pushNamed(routeName);

  void pop() => Navigator.of(this).pop();

  void pushReplacment(String routeName) =>
      Navigator.of(this).pushReplacementNamed(routeName);

  TextTheme  get theme => Theme.of(this).textTheme;
  ColorScheme  get colors => Theme.of(this).colorScheme;
}
