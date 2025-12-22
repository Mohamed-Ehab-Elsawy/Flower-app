import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/signup_screen.dart';

class AppRoutes {
  static const String signup = '/signup';
  static const String login = '/login';

}

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
    case AppRoutes.signup:
      return MaterialPageRoute(builder: (_) => SignUpScreen());
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
