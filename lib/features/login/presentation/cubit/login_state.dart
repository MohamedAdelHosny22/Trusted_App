import '../../data/models/user_model.dart';

/// LoginStatus - Authentication status enum
///
/// Represents the current state of the login process
enum LoginStatus {
  initial,   // Before any action
  loading,   // Login in progress
  success,   // Login completed successfully
  failure,   // Login failed with error
}

/// LoginState - Unified state for login feature
///
/// Contains all data needed for UI to react to login state changes
class LoginState {
  final LoginStatus status;
  final UserModel? user;
  final String? errorMessage;

  const LoginState({
    this.status = LoginStatus.initial,
    this.user,
    this.errorMessage,
  });

  /// Initial state factory constructor
  const LoginState.initial() : status = LoginStatus.initial, user = null, errorMessage = null;

  /// Convenience getters for common checks
  bool get isLoading => status == LoginStatus.loading;
  bool get isSuccess => status == LoginStatus.success;
  bool get isFailure => status == LoginStatus.failure;

  /// CopyWith for immutable state updates
  LoginState copyWith({
    LoginStatus? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Loading state
  LoginState asLoading() {
    return copyWith(
      status: LoginStatus.loading,
      errorMessage: null,
    );
  }

  /// Success state
  LoginState asSuccess(UserModel user) {
    return copyWith(
      status: LoginStatus.success,
      user: user,
      errorMessage: null,
    );
  }

  /// Failure state
  LoginState asFailure(String message) {
    return copyWith(
      status: LoginStatus.failure,
      errorMessage: message,
    );
  }

  @override
  String toString() {
    return 'LoginState(status: $status, user: ${user?.username}, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginState &&
        other.status == status &&
        other.user == user &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => status.hashCode ^ user.hashCode ^ errorMessage.hashCode;
}
