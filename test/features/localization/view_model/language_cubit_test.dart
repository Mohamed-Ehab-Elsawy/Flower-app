import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/features/localization/model/app_language.dart';
import 'package:flower_app/features/localization/view_model/language_cubit.dart';
import 'package:flower_app/features/localization/view_model/language_events.dart';
import 'package:flower_app/features/localization/view_model/language_states.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LanguageCubit', () {
    blocTest<LanguageCubit, LanguageStates>(
      "emits state with selectedLanguage = 'en' when SelectLanguage('en') is called",
      build: () => LanguageCubit(),
      act: (cubit) =>
          cubit.doIntent(SelectLanguage(selectedLanguage: AppLanguage.english)),
      expect: () => [
        const LanguageStates(selectedLanguage: AppLanguage.english),
      ],
    );

    blocTest<LanguageCubit, LanguageStates>(
      "emits state with selectedLanguage = 'ar' when SelectLanguage('ar') is called",
      build: () => LanguageCubit(),
      act: (cubit) =>
          cubit.doIntent(SelectLanguage(selectedLanguage: AppLanguage.arabic)),
      expect: () => [
        const LanguageStates(selectedLanguage: AppLanguage.arabic),
      ],
    );
  });
}
