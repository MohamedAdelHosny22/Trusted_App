
import 'package:trusted_app/features/login/data/models/user_model.dart';

/// SignupState - State management for signup feature
///
/// Represents all possible states during registration flow
/// Follows the single-state pattern with status tracking
class SignupState {
  final SignupStatus status;
  final UserModel? user;
  final String? errorMessage;

  const SignupState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  /// Initial state - ready for user input
  const SignupState.initial() : this(status: SignupStatus.initial);

  /// Loading state - signup in progress
  const SignupState.loading() : this(status: SignupStatus.loading);

  /// Success state - signup completed successfully
  const SignupState.success(UserModel user) : this(status: SignupStatus.success, user: user);

  /// Failure state - signup failed with error
  const SignupState.failure(String errorMessage) : this(status: SignupStatus.failure, errorMessage: errorMessage);

  /// Convenience getters
  bool get isInitial => status == SignupStatus.initial;
  bool get isLoading => status == SignupStatus.loading;
  bool get isSuccess => status == SignupStatus.success;
  bool get isFailure => status == SignupStatus.failure;

  /// Helper methods for state transitions
  SignupState asLoading() => const SignupState.loading();
  SignupState asSuccess(UserModel user) => SignupState.success(user);
  SignupState asFailure(String error) => SignupState.failure(error);

  @override
  String toString() {
    return 'SignupState(status: $status, user: $user, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignupState &&
        other.status == status &&
        other.user == user &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => status.hashCode ^ user.hashCode ^ errorMessage.hashCode;
}

/// SignupStatus - Enum representing signup flow states
enum SignupStatus {
  /// Ready for user input
  initial,

  /// Signup request in progress
  loading,

  /// Signup completed successfully
  success,

  /// Signup failed with error
  failure,
}
