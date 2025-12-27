class ForgetPasswordState {
  final bool? isLoading;
  final String? error;
  final String? message;
  final int resendRemainingSeconds;

  const ForgetPasswordState({
    this.isLoading = false,
    this.error,
    this.message,
    this.resendRemainingSeconds = 30,
  });

  ForgetPasswordState copyWith({
    bool? isLoading,
    String? error,
    String? message,
    int? resendRemainingSeconds,
  }) {
    return ForgetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      message: message ?? this.message,
      resendRemainingSeconds:
          resendRemainingSeconds ?? this.resendRemainingSeconds,
    );
  }
}

sealed class ForgetPasswordIntent {}

class SendResetPasswordCodeIntent extends ForgetPasswordIntent {
  final String email;
  SendResetPasswordCodeIntent(this.email);
}

class VerifyResetPasswordCodeIntent extends ForgetPasswordIntent {
  final String resetCode;
  VerifyResetPasswordCodeIntent(this.resetCode);
}

class ResetPasswordIntent extends ForgetPasswordIntent {
  final String email;
  final String password;
  ResetPasswordIntent(this.email, this.password);
}

sealed class ForgetPasswordUIEvents {}

class ForgetPasswordShowToastEvent extends ForgetPasswordUIEvents {
  final String message;
  ForgetPasswordShowToastEvent(this.message);
}

class NavigateToOTPEvent extends ForgetPasswordUIEvents {}

class NavigateToChangePasswordEvent extends ForgetPasswordUIEvents {}

class NavigateToLoginEvent extends ForgetPasswordUIEvents {}
