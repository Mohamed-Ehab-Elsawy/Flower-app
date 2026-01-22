import 'package:flower_app/core/api/models/requests/user_request.dart';

sealed class SignupEvents {}

sealed class SignupUiEvent {}

class SignUpEvent extends SignupEvents {
  final UserSignupRequest userRequest;
  SignUpEvent({required this.userRequest});
}

class SelectGender extends SignupEvents {
  final String selectGender;
  SelectGender({required this.selectGender});
}

class ShowToast extends SignupUiEvent {
  final String message;
  final bool isError;
  ShowToast({required this.message, required this.isError});
}

class NavigateToLogin extends SignupUiEvent {}

class NavigateToTermsConditions extends SignupUiEvent {}
