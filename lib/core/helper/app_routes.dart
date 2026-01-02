import 'package:flower_app/core/app/presentation/view/app_section.dart';
import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_view_model.dart';
import 'package:flower_app/features/auth/presentation/pages/forget_password/forget_password_view.dart';
import 'package:flower_app/features/auth/presentation/pages/login_screen.dart';
import 'package:flower_app/features/auth/presentation/pages/signup_screen.dart';
import 'package:flower_app/features/auth/presentation/pages/terms_and_conditions.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_cubit.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_intents.dart';
import 'package:flower_app/features/home/presentation/occasions/occasions_cubit.dart';
import 'package:flower_app/features/home/presentation/view/occasions/OccasionsScreen.dart';
import 'package:flower_app/features/home/presentation/view/testScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../di/di.dart';

class AppRoutes {
  static const String signup = '/signup';
  static const String login = '/login';
  static const String appSection = "appSection";
  static const String forgetPassword = "/forgetPassword";
  static const String terms = '/terms';
  static const String occasion = '/occasion';
  static const String testScreen = '/TestScreen';
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
      return MaterialPageRoute(builder: (_) => const SignUpScreen());

    case AppRoutes.terms:
      return MaterialPageRoute(builder: (_) => const TermsAndConditions());

    case AppRoutes.forgetPassword:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt.get<ForgetPasswordCubit>(),
          child: const ForgetPasswordView(),
        ),
      );
    case AppRoutes.occasion:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => BlocProvider<OccasionsCubit>(
          create: (context) => getIt.get<OccasionsCubit>(),

          child: const OccasionScreen(),
        ),
      );
    case AppRoutes.testScreen:
      return MaterialPageRoute(builder: (_) => const TestScreen());

    case AppRoutes.appSection:
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AppSectionViewModel()),
            BlocProvider(
              create: (context) =>
                  getIt.get<CategoriesViewCubit>()
                    ..doIntent(InitCategoriesViewIntent()),
            ),
          ],
          child: const AppSection(),
        ),
      );

    // case AppRoutes.occasion:
    //   return MaterialPageRoute(
    //     settings: settings,
    //     builder: (_) => BlocProvider<OccasionsCubit>(
    //       create: (context) => getIt.get< OccasionsCubit>(),
    //
    //       child:  OccasionScreen(),
    //     ),
    //   );
    // case AppRoutes.testScreen:
    //   return MaterialPageRoute(builder: (_) =>  TestScreen());
    default:
      return null;
  }
}
