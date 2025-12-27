sealed class LoginViewIntent {}

final class UserLoginIntent extends LoginViewIntent {
  final String email;
  final String password;

  UserLoginIntent({required this.email, required this.password});
}

final class GuestLoginIntent extends LoginViewIntent {}

final class SignupIntent extends LoginViewIntent {}

final class ForgetPasswordIntent extends LoginViewIntent {}

sealed class LoginUIEvents {}

final class NavigateToHome extends LoginUIEvents {}

final class NavigateToSignup extends LoginUIEvents {}

final class NavigateToForgetPassword extends LoginUIEvents {}

final class LoginViewShowToast extends LoginUIEvents {
  final String message;
  final bool isError;

  LoginViewShowToast({
    this.message = "Something went wrong",
    this.isError = false,
  });
}
