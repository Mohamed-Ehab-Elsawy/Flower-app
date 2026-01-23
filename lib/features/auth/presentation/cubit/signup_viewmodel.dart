import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/signup_event.dart';
import 'package:flower_app/features/auth/presentation/cubit/signup_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpViewModel extends Cubit<SignupStates> with EquatableMixin {
  final SignUpUseCase _signUpUseCase;
  SignUpViewModel(this._signUpUseCase) : super(const SignupStates());

  final StreamController<SignupUiEvent> _signupUiEvent =
      StreamController.broadcast();
  Stream<SignupUiEvent> get signupUiEvent => _signupUiEvent.stream;
  @override
  List<Object> get props {
    return [state];
  }

  void doIntent(SignupEvents event) {
    switch (event) {
      case SignUpEvent():
        _signUp(event.userRequest);
      case SelectGender():
        _selectedGender(event.selectGender);
    }
  }

  void doEvent(SignupUiEvent event) {
    switch (event) {
      case ShowToast():
        _signupUiEvent.add(
          ShowToast(message: event.message, isError: event.isError),
        );
      case NavigateToLogin():
        _signupUiEvent.add(NavigateToLogin());
      case NavigateToTermsConditions():
        _signupUiEvent.add(NavigateToTermsConditions());
    }
  }

  void _signUp(UserSignupRequest userRequest) async {
    emit(
      state.copyWith(
        signUpState: const BaseState<UserEntity>(
          requestState: RequestState.loading,
        ),
      ),
    );
    Result<UserEntity> response = await _signUpUseCase(userRequest);
    switch (response) {
      case Success<UserEntity>():
        emit(
          state.copyWith(
            signUpState: BaseState<UserEntity>.loaded(response.data),
          ),
        );
      case Failure<UserEntity>():
        emit(
          state.copyWith(
            signUpState: BaseState<UserEntity>.error(
              response.errorMessage.toString(),
            ),
          ),
        );
    }
  }

  void _selectedGender(String selectGender) {
    emit(state.copyWith(selectedGender: selectGender));
  }
}
