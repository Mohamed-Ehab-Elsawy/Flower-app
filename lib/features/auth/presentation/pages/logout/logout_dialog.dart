import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/auth/presentation/cubit/logout/logout_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/logout/logout_events.dart';
import 'package:flower_app/features/auth/presentation/cubit/logout/logout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogOuDialog extends StatefulWidget {
  const LogOuDialog({super.key});

  @override
  State<LogOuDialog> createState() => _LogOuDialogState();
}

class _LogOuDialogState extends State<LogOuDialog> {
  LogoutCubit logoutCubit = getIt<LogoutCubit>();

  @override
  void initState() {
    super.initState();
    logoutCubit.logoutUiEvent.listen((event) {
      switch (event) {
        case ShowToast():
          {
            Toast.showToast(context, event.message, isError: event.isError);
          }

        case NavigateToLogin():
          {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          }

        case NavigatePop():
          {
            Navigator.pop(context);
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocProvider<LogoutCubit>(
        create: (context) => logoutCubit,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("LOGOUT".tr(), style: context.appTheme.semiBold18),

            const SizedBox(height: 12),

            Text("Confirm logout!!".tr(), style: context.appTheme.medium16),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      logoutCubit.doEvent(NavigatePop());
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: context.appTheme.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "Cancel",
                      style: context.appTheme.medium16,
                    ).tr(),
                  ),
                ),

                const SizedBox(width: 12),

                BlocListener<LogoutCubit, LogoutStates>(
                  listener: (context, state) {
                    final logoutState = state.logoutState;
                    if (logoutState == null) {
                      return;
                    } else if (logoutState.errorMessage != null) {
                      logoutState.isError == true;
                      logoutCubit.doEvent(
                        ShowToast(
                          message: logoutState.errorMessage!,
                          isError: logoutState.isError,
                        ),
                      );
                    } else if (logoutState.data != null) {
                      logoutState.isError == false;

                      logoutCubit.doEvent(
                        ShowToast(
                          message: "logout_success".tr(),
                          isError: logoutState.isError,
                        ),
                      );
                      logoutCubit.doEvent(NavigateToLogin());
                    }
                  },

                  child: Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        logoutCubit.doIntent(LogoutEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.appTheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                      ),
                      child: Text(
                        "Logout".tr(),
                        style: context.appTheme.medium16.copyWith(
                          color: context.appTheme.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
