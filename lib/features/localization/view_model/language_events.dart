sealed class LanguageEvents {}

class SelectLanguage extends LanguageEvents {
  final String selectedLanguage;

  SelectLanguage({required this.selectedLanguage});
}
