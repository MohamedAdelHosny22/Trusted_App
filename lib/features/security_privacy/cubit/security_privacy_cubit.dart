import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trusted_app/features/security_privacy/data/models/change_password_request_model.dart';
import 'package:trusted_app/features/security_privacy/data/repositories/security_repository.dart';
import 'security_privacy_state.dart';

/// SecurityPrivacyCubit - State management for security & privacy feature
///
/// Responsibilities:
/// - Fetch security settings
/// - Handle password changes
/// - Toggle security features (2FA, biometric)
/// - Emit state changes for UI to react
///
/// NOT responsible for:
/// - Navigation (UI handles this via BlocListener)
/// - Showing snackbars (UI handles this via BlocListener)
/// - Direct API calls (delegated to Repository)
class SecurityPrivacyCubit extends Cubit<SecurityPrivacyState> {
  final SecurityRepository _repository;

  SecurityPrivacyCubit(this._repository) : super(const SecurityPrivacyState.initial()) {
    // Load settings on initialization
    loadSecuritySettings();
  }

  /// Fetch user security settings
  ///
  /// Calls repository and emits appropriate states
  Future<void> loadSecuritySettings() async {
    emit(state.asLoading());

    try {
      final settings = await _repository.getSecuritySettings();
      emit(state.asSuccess(settings: settings));
    } on SecurityFailure catch (error) {
      emit(state.asFailure(error.message));
    } catch (error) {
      emit(state.asFailure('Failed to load security settings. Please try again.'));
    }
  }

  /// Change user password
  ///
  /// Validates input, calls repository, and emits appropriate states
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    // Validate input
    final validationResult = _validatePasswordChange(
      currentPassword,
      newPassword,
      confirmNewPassword,
    );
    if (validationResult != null) {
      emit(state.asFailure(validationResult));
      return;
    }

    emit(state.asLoading());

    try {
      final request = ChangePasswordRequestModel(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      final updatedSettings = await _repository.changePassword(request);
      emit(state.asSuccess(
        settings: updatedSettings,
        message: 'Password changed successfully',
      ));
    } on SecurityFailure catch (error) {
      emit(state.asFailure(error.message));
    } catch (error) {
      emit(state.asFailure('Failed to change password. Please try again.'));
    }
  }

  /// Toggle two-factor authentication
  Future<void> toggleTwoFactor(bool enabled) async {
    emit(state.asLoading());

    try {
      final updatedSettings = await _repository.toggleTwoFactor(enabled);
      final message = enabled
          ? 'Two-factor authentication enabled'
          : 'Two-factor authentication disabled';
      emit(state.asSuccess(settings: updatedSettings, message: message));
    } on SecurityFailure catch (error) {
      emit(state.asFailure(error.message));
    } catch (error) {
      emit(state.asFailure('Failed to update two-factor settings. Please try again.'));
    }
  }

  /// Toggle biometric authentication
  Future<void> toggleBiometric(bool enabled) async {
    emit(state.asLoading());

    try {
      final updatedSettings = await _repository.toggleBiometric(enabled);
      final message = enabled
          ? 'Biometric authentication enabled'
          : 'Biometric authentication disabled';
      emit(state.asSuccess(settings: updatedSettings, message: message));
    } on SecurityFailure catch (error) {
      emit(state.asFailure(error.message));
    } catch (error) {
      emit(state.asFailure('Failed to update biometric settings. Please try again.'));
    }
  }

  /// Validate password change inputs
  ///
  /// Returns error message if validation fails, null if valid
  String? _validatePasswordChange(
    String currentPassword,
    String newPassword,
    String confirmNewPassword,
  ) {
    if (currentPassword.isEmpty) {
      return 'Current password is required';
    }

    if (newPassword.isEmpty) {
      return 'New password is required';
    }

    if (newPassword.length < 8) {
      return 'New password must be at least 8 characters';
    }

    if (newPassword == currentPassword) {
      return 'New password must be different from current password';
    }

    if (confirmNewPassword != newPassword) {
      return 'Passwords do not match';
    }

    return null; // Valid
  }

  /// Clear error message (for UI to dismiss error state)
  void clearError() {
    if (state.isFailure) {
      emit(state.copyWith(errorMessage: null));
    }
  }

  /// Clear success message (for UI to dismiss success state)
  void clearSuccess() {
    if (state.isSuccess && state.successMessage != null) {
      emit(state.copyWith(successMessage: null));
    }
  }

  /// Reset state to initial
  void reset() {
    emit(const SecurityPrivacyState.initial());
  }
}
