import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
@injectable
class AppSectionViewModel extends Cubit<AppSectionState> {
  AppSectionViewModel() : super(const AppSectionState());

  final _uiController = StreamController<AppSectionUIEvents>.broadcast();

  Stream<AppSectionUIEvents> get uiEventsStream => _uiController.stream;

  void doIntent(AppSectionIntent intent) {
    switch (intent) {
      case ViewHomeIntent():
        emit(state.copyWith(currentTab: 0, selectedCategoryIndex: null));
        _uiController.add(SwitchTabEvent(0));

      case ViewCategoryIntent():
        emit(
          state.copyWith(
            currentTab: 1,
            selectedCategoryIndex: intent.categoryIndex,
          ),
        );
        _uiController.add(SwitchTabEvent(1));

      case ViewCartIntent():
        emit(state.copyWith(currentTab: 2));
        _uiController.add(SwitchTabEvent(2));

      case ViewProfileIntent():
        emit(state.copyWith(currentTab: 3));
        _uiController.add(SwitchTabEvent(3));
    }
  }

  @override
  Future<void> close() {
    _uiController.close();
    return super.close();
  }
}

class AppSectionState extends Equatable {
  final int currentTab;
  final int? selectedCategoryIndex;

  const AppSectionState({this.currentTab = 0, this.selectedCategoryIndex});

  AppSectionState copyWith({int? currentTab, int? selectedCategoryIndex}) {
    return AppSectionState(
      currentTab: currentTab ?? this.currentTab,
      selectedCategoryIndex: selectedCategoryIndex,
    );
  }

  @override
  List<Object?> get props => [currentTab, selectedCategoryIndex];
}

sealed class AppSectionIntent {}

class ViewHomeIntent extends AppSectionIntent {}

class ViewCategoryIntent extends AppSectionIntent {
  int? categoryIndex;

  ViewCategoryIntent(this.categoryIndex);
}

class ViewCartIntent extends AppSectionIntent {}

class ViewProfileIntent extends AppSectionIntent {}

sealed class AppSectionUIEvents {}

class SwitchTabEvent extends AppSectionUIEvents {
  final int index;

  SwitchTabEvent(this.index);
}
