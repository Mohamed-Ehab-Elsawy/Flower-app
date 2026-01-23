import 'dart:async';

import 'package:flower_app/core/app/domain/use_case/get_user_data_use_case.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'app_section_contracts.dart';

@injectable
class AppSectionViewModel extends Cubit<AppSectionState> {
  final GetUserDataUseCase _getUserDataUseCase;

  UserEntity _user = UserEntity();

  UserEntity get user => _user;

  final _uiStreamController = StreamController<AppSectionUIEvents>.broadcast();

  Stream<AppSectionUIEvents> get uiStream => _uiStreamController.stream;

  AppSectionViewModel(this._getUserDataUseCase)
    : super(const AppSectionState());

  void doIntent(AppSectionIntent intent) {
    switch (intent) {
      case AppSectionInitIntent():
        _init();

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

  void _init() {
    _getUserData();
  }

  void _switchToHome() =>
      emit(state.copyWith(currentTab: 0, selectedCategoryIndex: null));

  void _switchToCategory(int index) =>
      emit(state.copyWith(currentTab: 1, selectedCategoryIndex: index));

  void _switchToCart() => emit(state.copyWith(currentTab: 2));

  void _switchToProfile() => emit(state.copyWith(currentTab: 3));

  void _getUserData() async {
    final result = await _getUserDataUseCase.call();
    switch (result) {
      case Success<UserEntity>():
        _user = result.data;
      case Failure<UserEntity>():
        _uiStreamController.add(AppSectionLogoutEvent(result.errorMessage));
    }
  }

  @override
  Future<void> close() {
    _uiStreamController.close();
    return super.close();
  }
}
