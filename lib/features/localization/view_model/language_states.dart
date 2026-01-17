import 'package:equatable/equatable.dart' show Equatable;

class LanguageStates extends Equatable {
  final String? selectedLanguage;

  const LanguageStates({this.selectedLanguage});

  @override
  List<Object?> get props => [selectedLanguage];

  LanguageStates copyWith({String? selectedLanguage}) {
    return LanguageStates(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
