import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'app_section_contracts.dart';
// ignore: must_be_immutable
class AppSectionViewModel extends Cubit<int> with EquatableMixin {
  AppSectionViewModel() : super(0);


@injectable
class AppSectionViewModel extends Cubit<AppSectionState> {
  AppSectionViewModel() : super(const AppSectionState());

  void doIntent(AppSectionIntent intent) {
    switch (intent) {
      case ViewHomeIntent():
        _switchToHome();

      case ViewCategoryIntent():
        _switchToCategory(intent.categoryIndex ?? 0);

      case ViewCartIntent():
        _switchToCart();

      case ViewProfileIntent():
        _switchToProfile();
    }
  }

  _switchToHome() {
    emit(state.copyWith(currentTab: 0, selectedCategoryIndex: null));
  }

  _switchToCategory(int index) {
    emit(state.copyWith(currentTab: 1, selectedCategoryIndex: index));
  }

  _switchToCart() {
    emit(state.copyWith(currentTab: 2));
  }

  _switchToProfile() {
    emit(state.copyWith(currentTab: 3));
  }
}
