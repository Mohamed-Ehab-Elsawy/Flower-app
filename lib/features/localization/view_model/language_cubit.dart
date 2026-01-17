import 'package:equatable/equatable.dart' show EquatableMixin;
import 'package:flower_app/features/localization/view_model/language_events.dart';
import 'package:flower_app/features/localization/view_model/language_states.dart'
    show LanguageStates;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LanguageCubit extends Cubit<LanguageStates> with EquatableMixin {
  LanguageCubit() : super(const LanguageStates());

  @override
  List<Object> get props {
    return [state];
  }

  void doIntent(LanguageEvents event) {
    switch (event) {
      case SelectLanguage():
        _selectLanguage(event.selectedLanguage);
    }
  }

  void _selectLanguage(String selectedLanguage) {
    emit(state.copyWith(selectedLanguage: selectedLanguage));
  }
}
