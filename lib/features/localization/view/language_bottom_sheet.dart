import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/features/localization/view_model/language_cubit.dart';
import 'package:flower_app/features/localization/view_model/language_events.dart';
import 'package:flower_app/features/localization/view_model/language_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late LanguageCubit languageCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    languageCubit = getIt<LanguageCubit>();
    final currentLocale = context.locale;
    if (currentLocale.languageCode == 'en') {
      languageCubit.doIntent(SelectLanguage(selectedLanguage: "English"));
    } else if (currentLocale.languageCode == 'ar') {
      languageCubit.doIntent(SelectLanguage(selectedLanguage: "Arabic"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>.value(
      value: languageCubit,
      child: BlocBuilder<LanguageCubit, LanguageStates>(
        builder: (context, state) {
          return Container(
            color: const Color(0xFFF9F9F9),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Change Language".tr(),
                    style: context.appTheme.semiBold24.copyWith(
                      color: context.appTheme.primary[50],
                    ),
                  ),
                  const SizedBox(height: 20),
                  RadioGroup<String>(
                    groupValue: state.selectedLanguage,
                    onChanged: (value) {
                      if (value == null) return;

                      languageCubit.doIntent(
                        SelectLanguage(selectedLanguage: value),
                      );

                      if (value == "English") {
                        context.setLocale(const Locale('en', 'US'));
                      } else if (value == "Arabic") {
                        context.setLocale(const Locale('ar', 'EG'));
                      }
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: RadioListTile<String>(
                            title: Text(
                              "English".tr(),
                              style: context.appTheme.medium16,
                            ),
                            value: "English",
                          ),
                        ),

                        const SizedBox(height: 10),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: RadioListTile<String>(
                            title: Text(
                              "Arabic".tr(),
                              style: context.appTheme.medium16,
                            ),
                            value: "Arabic",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
