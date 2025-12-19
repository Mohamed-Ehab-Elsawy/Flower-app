import 'package:flower_app/features/auth/presentation/pages/login.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = '/login';
}

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const Login());
    default:
      return _undefinedRoute();
  }
}

Route<dynamic> _undefinedRoute() {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      body: const Center(child: Text('No route defined for this path')),
    ),
  );
}
