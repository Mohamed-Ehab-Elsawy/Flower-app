import 'dart:async';

import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/helper/app_local_storage.dart';
import 'package:flower_app/core/helper/local_keys.dart';
import 'package:flower_app/features/auth/data/models/requests/change_password_request.dart';
import 'package:flower_app/features/auth/data/models/response/change_password_response.dart';
import 'package:flower_app/features/auth/domain/use_cases/change_password_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/change_password/change_password_events.dart';
import 'package:flower_app/features/auth/presentation/cubit/change_password/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordViewModel extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;
  ChangePasswordViewModel(this._changePasswordUseCase)
    : super(ChangePasswordState(BaseState.init()));

  final _uiEventsController =
      StreamController<ChangePasswordEvents>.broadcast();

  Stream<ChangePasswordEvents> get uiEventsStream => _uiEventsController.stream;

  void doEvent(ChangePasswordEvents event) {
    switch (event) {
      case ChangePasswordIntent():
        _changePassword(event.changePasswordRequest);
      case ChangePasswordShowToastEvent():
        _uiEventsController.add(
          ChangePasswordShowToastEvent(
            message: event.message,
            isError: event.isError,
          ),
        );
      case NavigateToEditProfileEvent():
        _uiEventsController.add(NavigateToEditProfileEvent());
    }
  }

  Future<void> _changePassword(
    ChangePasswordRequest changePasswordRequest,
  ) async {
    emit(
      state.copyWith(
        const BaseState<ChangePasswordResponse>(
          requestState: RequestState.loading,
        ),
      ),
    );

    final result = await _changePasswordUseCase.changePassword(
      changePasswordRequest: changePasswordRequest,
    );

    switch (result) {
      case Success<ChangePasswordResponse>():
        await AppLocalStorage.clearSecuredData(key: LocalKeys.authToken);

        await AppLocalStorage.setSecuredString(
          key: LocalKeys.authToken,
          value: result.data.token.toString(),
        );

        emit(state.copyWith(BaseState.loaded(result.data)));
        _uiEventsController.add(NavigateToEditProfileEvent());
        _uiEventsController.add(
          ChangePasswordShowToastEvent(
            message: result.data.message.toString(),
            isError: false,
          ),
        );

      case Failure<ChangePasswordResponse>():
        emit(state.copyWith(BaseState.error(result.errorMessage)));
        _uiEventsController.add(
          ChangePasswordShowToastEvent(
            message: result.errorMessage,
            isError: true,
          ),
        );
    }
  }
}
