import 'package:equatable/equatable.dart' show Equatable;
import 'package:flower_app/features/localization/model/app_language.dart';

class LanguageStates extends Equatable {
  final AppLanguage? selectedLanguage;

  const LanguageStates({this.selectedLanguage});

  @override
  List<Object?> get props => [selectedLanguage];

  LanguageStates copyWith({AppLanguage? selectedLanguage}) {
    return LanguageStates(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
