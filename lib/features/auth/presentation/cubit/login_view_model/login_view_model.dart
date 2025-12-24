import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response.dart';
import 'package:flower_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_states.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase) : super(LoginStates.initial());

  void doIntent(LoginEvents event) {
    switch (event) {
      case Login():
        _login(email: event.email, password: event.password);
    }
  }

  Future<void> _login({required String email, required String password}) async {
    emit(state.copyWith(login: state.login.loading));
    final LoginRequest request = LoginRequest(email: email, password: password);
    var response = await _loginUseCase.login(loginRequest: request);
    switch (response) {
      case Success<LoginResponse>():
        emit(state.copyWith(login: state.login.loaded(response.data)));
      case Failure<LoginResponse>():
        emit(state.copyWith(login: state.login.error(response.errorMessage)));
    }
  }
}
