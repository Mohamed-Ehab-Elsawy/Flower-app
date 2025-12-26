import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:flower_app/core/app/presentation/view/app_section.dart';
import 'package:flower_app/features/auth/presentation/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static const String login = '/login';
  static const String appSection = "APP-SECTION";
}

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const Login());
    case AppRoutes.appSection:
      return MaterialPageRoute(
        builder: (_) => BlocProvider<AppSectionViewModel>(
          create: (context) => AppSectionViewModel(),
          child: const AppSection(),
        ),
      );
    default:
      return _undefinedRoute();
  }
}

Route<dynamic> _undefinedRoute() {
  return MaterialPageRoute(
    builder: (_) => const Scaffold(
      body: Center(child: Text('No route defined for this path')),
    ),
  );
}
