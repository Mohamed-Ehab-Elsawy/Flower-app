import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import 'package:flower_app/features/auth/presentation/pages/forget_password/forget_password_view.dart';
import 'package:flower_app/features/auth/presentation/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static const String login = '/login';
  static const String forgetPassword = '/forgetPassword';
}

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const Login());
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

Route<dynamic> _undefinedRoute() {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      body: const Center(child: Text('No route defined for this path')),
    ),
  );
}
