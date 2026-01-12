import 'package:flower_app/features/auth/data/models/requests/change_password_request.dart';

sealed class ChangePasswordEvents {}

class ChangePasswordIntent extends ChangePasswordEvents {
  final ChangePasswordRequest changePasswordRequest;
  ChangePasswordIntent({required this.changePasswordRequest});
}

class ChangePasswordShowToastEvent extends ChangePasswordEvents {
  final String message;
  bool? isError;
  ChangePasswordShowToastEvent({required this.message, this.isError});
}

class NavigateToEditProfileEvent extends ChangePasswordEvents {}
