import 'package:flower_app/features/localization/model/app_language.dart';

sealed class LanguageEvents {}

class SelectLanguage extends LanguageEvents {
  final AppLanguage selectedLanguage;

  SelectLanguage({required this.selectedLanguage});
}
