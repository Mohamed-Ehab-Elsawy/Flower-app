import 'package:flower_app/core/app/presentation/view/app_section.dart';
import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_view_model.dart';
import 'package:flower_app/features/auth/presentation/pages/forget_password/forget_password_view.dart';
import 'package:flower_app/features/auth/presentation/pages/login_screen.dart';
import 'package:flower_app/features/auth/presentation/pages/signup_screen.dart';
import 'package:flower_app/features/auth/presentation/pages/terms_and_conditions.dart';
import 'package:flower_app/features/home/presentation/view/best_seller_view.dart';
import 'package:flower_app/features/home/presentation/view/occasions/occasion_screen.dart';
import 'package:flower_app/features/home/presentation/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../di/di.dart';

class AppRoutes {
  static const String signup = '/signup';
  static const String login = '/login';
  static const String appSection = "appSection";
  static const String forgetPassword = "/forgetPassword";
  static const String terms = '/terms';
  static const String mostSelling = '/mostSelling';
  static const String productDetails = '/productDetails';
  static const String occasion = '/occasion';
  static const String testScreen = '/TestScreen';
}

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.mostSelling:
      return MaterialPageRoute(builder: (_) => const BestSellerView());
    case AppRoutes.signup:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());
    case AppRoutes.appSection:
      var cubit = getIt.get<HomeViewModel>();
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider<AppSectionViewModel>(
              create: (context) => getIt.get<AppSectionViewModel>(),
            ),
            BlocProvider(create: (context) => cubit..doIntent(FetchHomeData())),
          ],
          child: const AppSection(),
        ),
      );
    case AppRoutes.login:
      var cubit = getIt.get<LoginViewModel>();
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => cubit,
          child: const LoginScreen(),
        ),
      );

    case AppRoutes.terms:
      return MaterialPageRoute(builder: (_) => const TermsAndConditions());
    case AppRoutes.occasion:
      return MaterialPageRoute(
        builder: (_) => const OccasionScreen(),
        settings: settings,
      );

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
