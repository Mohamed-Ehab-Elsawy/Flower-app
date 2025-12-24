sealed class LoginEvents {}

final class Login extends LoginEvents {
  final String email;
  final String password;
  Login({required this.email, required this.password});
}
