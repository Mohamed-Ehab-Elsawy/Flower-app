import 'package:flower_app/core/di/di.dart';

import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_view_model.dart';
import 'package:flower_app/features/auth/presentation/pages/login_screen.dart';
import 'package:flower_app/features/auth/presentation/pages/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static const String signup = '/signup';
  static const String login = '/login';
  static const String home = '/home';
  static const String forgetPassword = "/forgetPassword";
  static const String terms = '/terms';
}

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.signup:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());
    case AppRoutes.login:
      var cubit = getIt.get<LoginViewModel>();
      return MaterialPageRoute(
        builder: (_) =>
            BlocProvider(
                create: (context) => cubit, child: const LoginScreen()),
      );
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => const Scaffold());
    case AppRoutes.forgetPassword:
      return MaterialPageRoute(builder: (_) => const Scaffold());
    case AppRoutes.terms:
      return MaterialPageRoute(builder: (_) => const TermsAndConditions());
    default:
      return null;
  }
}