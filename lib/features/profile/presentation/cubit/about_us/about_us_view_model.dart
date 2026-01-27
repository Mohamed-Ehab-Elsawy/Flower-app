import 'dart:async';

import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/domain/entity/about_us_entity.dart';
import 'package:flower_app/features/profile/domain/usecases/about_us_use_case.dart';
import 'package:flower_app/features/profile/presentation/cubit/about_us/about_us_intents.dart';
import 'package:flower_app/features/profile/presentation/cubit/about_us/about_us_state.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/managers/main_profile_view_ui_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AboutUsViewModel extends Cubit<AboutUsState> {
  final AboutUsUseCase _aboutUsUseCase;
  AboutUsViewModel(this._aboutUsUseCase) : super(AboutUsState.init());
  final _uiControllerBroadcast =
      StreamController<MainProfileViewUIEvents>.broadcast();

  Stream<MainProfileViewUIEvents> get uiEvents => _uiControllerBroadcast.stream;

  doIntent(AboutUsIntent intent) {
    switch (intent) {
      case GetAboutUsIntent():
        _getAboutUsData();
    }
  }

  _getAboutUsData() async {
    emit(state.copyWith(aboutStates: state.aboutStates.loading));
    final response = await _aboutUsUseCase.invoke();
    switch (response) {
      case Success<AboutUsEntity>():
        emit(
          state.copyWith(aboutStates: state.aboutStates.loaded(response.data)),
        );
      case Failure<AboutUsEntity>():
        emit(
          state.copyWith(
            aboutStates: state.aboutStates.error(response.errorMessage),
          ),
        );
    }
  }

  @override
  Future<void> close() {
    _uiControllerBroadcast.close();
    return super.close();
  }
}
