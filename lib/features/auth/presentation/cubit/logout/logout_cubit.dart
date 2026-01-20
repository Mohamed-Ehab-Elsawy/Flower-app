import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/helper/app_local_storage.dart';
import 'package:flower_app/core/helper/local_keys.dart';
import 'package:flower_app/features/auth/domain/models/logout_response_entity.dart';
import 'package:flower_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/logout/logout_events.dart';
import 'package:flower_app/features/auth/presentation/cubit/logout/logout_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutCubit extends Cubit<LogoutStates> with EquatableMixin {
  final LogoutUseCase _logoutUseCase;

  LogoutCubit(this._logoutUseCase) : super(const LogoutStates());

  final StreamController<LogoutUiEvents> _logoutUiEvent =
      StreamController.broadcast();

  Stream<LogoutUiEvents> get logoutUiEvent => _logoutUiEvent.stream;

  @override
  List<Object> get props {
    return [state];
  }

  void doIntent(LogoutEvents event) {
    switch (event) {
      case LogoutEvent():
        _logout();
    }
  }

  void doEvent(LogoutUiEvents event) {
    switch (event) {
      case ShowToast():
        _logoutUiEvent.add(
          ShowToast(message: event.message, isError: event.isError),
        );
      case NavigateToLogin():
        _logoutUiEvent.add(NavigateToLogin());
      case NavigatePop():
        _logoutUiEvent.add(NavigatePop());
    }
  }

  void _logout() async {
    emit(
      state.copyWith(
        logoutState: const BaseState<LogoutResponseEntity>(
          requestState: RequestState.loading,
        ),
      ),
    );
    Result<LogoutResponseEntity> response = await _logoutUseCase();
    switch (response) {
      case Success<LogoutResponseEntity>():
        {
          emit(
            state.copyWith(
              logoutState: BaseState<LogoutResponseEntity>.loaded(
                response.data,
              ),
            ),
          );
          await AppLocalStorage.clearSecuredData(key: LocalKeys.authToken);
          await AppLocalStorage.removeData(LocalKeys.user);
        }
      case Failure<LogoutResponseEntity>():
        emit(
          state.copyWith(
            logoutState: BaseState<LogoutResponseEntity>.error(
              response.errorMessage.toString(),
            ),
          ),
        );
    }
  }
}
