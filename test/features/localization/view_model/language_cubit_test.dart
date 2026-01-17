import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/features/localization/view_model/language_cubit.dart';
import 'package:flower_app/features/localization/view_model/language_events.dart';
import 'package:flower_app/features/localization/view_model/language_states.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LanguageCubit', () {
    blocTest<LanguageCubit, LanguageStates>(
      "emits state with selectedLanguage = 'en' when SelectLanguage('en') is called",
      build: () => LanguageCubit(),
      act: (cubit) => cubit.doIntent(SelectLanguage(selectedLanguage: "en")),
      expect: () => [const LanguageStates(selectedLanguage: "en")],
    );

    blocTest<LanguageCubit, LanguageStates>(
      "emits state with selectedLanguage = 'ar' when SelectLanguage('ar') is called",
      build: () => LanguageCubit(),
      act: (cubit) => cubit.doIntent(SelectLanguage(selectedLanguage: "ar")),
      expect: () => [const LanguageStates(selectedLanguage: "ar")],
    );
  });
}
