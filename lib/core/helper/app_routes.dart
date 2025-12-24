import 'package:flower_app/core/di/di.dart';

import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_view_model.dart';
import 'package:flower_app/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String forgetPassword = "/forgetPassword";
}

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.login:
      var cubit = getIt.get<LoginViewModel>();
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => cubit,
          child: const LoginScreen(),
        ),
      );

    case AppRoutes.signup:
      return MaterialPageRoute(builder: (_) => const Scaffold());
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => const Scaffold());
    case AppRoutes.forgetPassword:
      return MaterialPageRoute(builder: (_) => const Scaffold());

    default:
      return null;
  }
}
