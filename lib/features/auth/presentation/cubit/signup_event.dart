import 'package:flower_app/core/api/models/requests/user_request.dart';

sealed class SignupEvents {}

sealed class SignupUiEvent {}

class SignUpEvent extends SignupEvents {
  UserSignupRequest userRequest;
  SignUpEvent({required this.userRequest});
}

class SelectGender extends SignupEvents {
  String selectGender;
  SelectGender({required this.selectGender});
}

class ShowToast extends SignupUiEvent {
  String message;
  ShowToast({required this.message});
}

class NavigateToLogin extends SignupUiEvent {}

class NavigateToLoginAfterSignup extends SignupUiEvent {}

class NavigateToTermsConditions extends SignupUiEvent {}
