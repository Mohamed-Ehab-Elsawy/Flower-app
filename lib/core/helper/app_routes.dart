import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import 'package:flower_app/features/auth/presentation/pages/forget_password/forget_password_view.dart';
import 'package:flower_app/features/auth/presentation/pages/login.dart';
import 'package:flower_app/features/auth/presentation/pages/signup_screen.dart';
import 'package:flower_app/features/auth/presentation/pages/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../di/di.dart';

class AppRoutes {
  static const String signup = '/signup';
  static const String login = '/login';
  static const String terms = '/terms';
  static const String forgetPassword = '/forgetPassword';
}

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
    case AppRoutes.signup:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const Login());
    case AppRoutes.terms:
      return MaterialPageRoute(builder: (_) => const TermsAndConditions());
    case AppRoutes.forgetPassword:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt.get<ForgetPasswordCubit>(),
          child: const ForgetPasswordView(),
        ),
      );
    default:
      return null;
  }
}
