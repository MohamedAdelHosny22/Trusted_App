
import 'package:trusted_app/features/security_privacy/data/models/security_settings_model.dart';

/// SecurityPrivacyStatus - Security operations status enum
///
/// Represents the current state of security operations
enum SecurityPrivacyStatus {
  initial,   // Before any action
  loading,   // Operation in progress
  success,   // Operation completed successfully
  failure,   // Operation failed with error
}

/// SecurityPrivacyState - Unified state for security & privacy feature
///
/// Contains all data needed for UI to react to state changes
class SecurityPrivacyState {
  final SecurityPrivacyStatus status;
  final SecuritySettingsModel? settings;
  final String? errorMessage;
  final String? successMessage;

  const SecurityPrivacyState({
    this.status = SecurityPrivacyStatus.initial,
    this.settings,
    this.errorMessage,
    this.successMessage,
  });

  /// Initial state factory constructor
  const SecurityPrivacyState.initial()
      : status = SecurityPrivacyStatus.initial,
        settings = null,
        errorMessage = null,
        successMessage = null;

  /// Convenience getters for common checks
  bool get isLoading => status == SecurityPrivacyStatus.loading;
  bool get isSuccess => status == SecurityPrivacyStatus.success;
  bool get isFailure => status == SecurityPrivacyStatus.failure;

  /// CopyWith for immutable state updates
  SecurityPrivacyState copyWith({
    SecurityPrivacyStatus? status,
    SecuritySettingsModel? settings,
    String? errorMessage,
    String? successMessage,
  }) {
    return SecurityPrivacyState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  /// Loading state
  SecurityPrivacyState asLoading() {
    return copyWith(
      status: SecurityPrivacyStatus.loading,
      errorMessage: null,
      successMessage: null,
    );
  }

  /// Success state
  SecurityPrivacyState asSuccess({
    SecuritySettingsModel? settings,
    String? message,
  }) {
    return copyWith(
      status: SecurityPrivacyStatus.success,
      settings: settings ?? this.settings,
      successMessage: message,
      errorMessage: null,
    );
  }

  /// Failure state
  SecurityPrivacyState asFailure(String message) {
    return copyWith(
      status: SecurityPrivacyStatus.failure,
      errorMessage: message,
      successMessage: null,
    );
  }

  @override
  String toString() {
    return 'SecurityPrivacyState(status: $status, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SecurityPrivacyState &&
        other.status == status &&
        other.settings == settings &&
        other.errorMessage == errorMessage &&
        other.successMessage == successMessage;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        settings.hashCode ^
        errorMessage.hashCode ^
        successMessage.hashCode;
  }
}
