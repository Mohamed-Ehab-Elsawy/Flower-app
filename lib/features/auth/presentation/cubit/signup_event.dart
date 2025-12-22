import 'package:flower_app/core/api/models/requests/user_request.dart';

sealed class SignupEvent {}

class SignUpEvent extends SignupEvent {
  UserRequest userRequest;
  SignUpEvent({required this.userRequest});
}
