part of 'login_view_model.dart';

class LoginState with EquatableMixin {
  final bool isLoading;
  final String successMessage;
  final String errorMessage;

  LoginState({
    this.isLoading = false,
    this.errorMessage = "",
    this.successMessage = "",
  });

  factory LoginState.initial() => LoginState();

  LoginState copyWith({
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) => LoginState(
    isLoading: isLoading ?? false,
    successMessage: successMessage ?? "",
    errorMessage: errorMessage ?? "",
  );

  @override
  List<Object?> get props => [isLoading, successMessage, errorMessage];
}
