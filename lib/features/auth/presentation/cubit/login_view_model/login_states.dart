part of 'login_view_model.dart';

class LoginStates {
  final BaseState<LoginResponse> login;
  LoginStates({required this.login});

  factory LoginStates.initial() => LoginStates(login: BaseState.init());

  LoginStates copyWith({BaseState<LoginResponse>? login}) {
    return LoginStates(login: login ?? this.login);
  }
}
