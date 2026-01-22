import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/features/localization/model/app_language.dart';
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
    final currentLanguage = AppLanguage.values.firstWhere(
      (lang) => lang.locale.languageCode == currentLocale.languageCode,
      orElse: () => AppLanguage.english,
    );

    languageCubit.doIntent(SelectLanguage(selectedLanguage: currentLanguage));
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
                children: [
                  Text(
                    "Change Language".tr(),
                    style: context.appTheme.semiBold24.copyWith(
                      color: context.appTheme.primary[50],
                    ),
                  ),
                  const SizedBox(height: 20),

                  RadioGroup<AppLanguage>(
                    groupValue: state.selectedLanguage,
                    onChanged: (AppLanguage? newValue) {
                      if (newValue == null) return;
                      languageCubit.doIntent(
                        SelectLanguage(selectedLanguage: newValue),
                      );
                      context.setLocale(newValue.locale);
                      //////////////////////////////////////////////////////////////////////
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: AppLanguage.values.map((language) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: RadioListTile<AppLanguage>(
                            value: language,
                            title: Text(
                              language.displayName.tr(),
                              style: context.appTheme.medium16.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                            activeColor: context.appTheme.primary,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                          ),
                        );
                      }).toList(),
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
