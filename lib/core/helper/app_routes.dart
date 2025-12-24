import 'package:flower_app/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = '/login';
}

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    default:
      return null;
  }
}
