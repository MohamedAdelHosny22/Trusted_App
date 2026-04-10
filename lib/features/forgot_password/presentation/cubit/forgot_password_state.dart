/// ForgotPasswordState - State management for forgot password feature
///
/// Represents all possible states during password reset flow
/// Follows the single-state pattern with status tracking
class ForgotPasswordState {
  final ForgotPasswordStatus status;
  final String? errorMessage;

  const ForgotPasswordState({
    required this.status,
    this.errorMessage,
  });

  /// Initial state - ready for user input
  const ForgotPasswordState.initial() : this(status: ForgotPasswordStatus.initial);

  /// Loading state - password reset in progress
  const ForgotPasswordState.loading() : this(status: ForgotPasswordStatus.loading);

  /// Success state - reset link sent successfully
  const ForgotPasswordState.success() : this(status: ForgotPasswordStatus.success);

  /// Failure state - password reset failed with error
  const ForgotPasswordState.failure(String errorMessage) : this(status: ForgotPasswordStatus.failure, errorMessage: errorMessage);

  /// Convenience getters
  bool get isInitial => status == ForgotPasswordStatus.initial;
  bool get isLoading => status == ForgotPasswordStatus.loading;
  bool get isSuccess => status == ForgotPasswordStatus.success;
  bool get isFailure => status == ForgotPasswordStatus.failure;

  /// Helper methods for state transitions
  ForgotPasswordState asLoading() => const ForgotPasswordState.loading();
  ForgotPasswordState asSuccess() => const ForgotPasswordState.success();
  ForgotPasswordState asFailure(String error) => ForgotPasswordState.failure(error);

  @override
  String toString() {
    return 'ForgotPasswordState(status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ForgotPasswordState &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => status.hashCode ^ errorMessage.hashCode;
}

/// ForgotPasswordStatus - Enum representing password reset flow states
enum ForgotPasswordStatus {
  /// Ready for user input
  initial,

  /// Password reset request in progress
  loading,

  /// Reset link sent successfully
  success,

  /// Password reset failed with error
  failure,
}
