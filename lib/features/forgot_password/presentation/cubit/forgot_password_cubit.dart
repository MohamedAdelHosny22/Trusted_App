import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/forgot_password_repository.dart';
import 'forgot_password_state.dart';

/// ForgotPasswordCubit - State management for forgot password feature
///
/// Responsibilities:
/// - Validate email input
/// - Call repository for password reset
/// - Emit state changes for UI to react
///
/// NOT responsible for:
/// - Navigation (UI handles this via BlocListener)
/// - Showing snackbars (UI handles this via BlocListener)
/// - Direct API calls (delegated to Repository)
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepository _repository;

  ForgotPasswordCubit(this._repository) : super(const ForgotPasswordState.initial());

  /// Request password reset link for email
  ///
  /// Validates email, calls repository, and emits appropriate states
  Future<void> sendResetLink({
    required String email,
  }) async {
    // Validate email
    final validationResult = _validateEmail(email);
    if (validationResult != null) {
      emit(state.asFailure(validationResult));
      return;
    }

    // Emit loading state
    emit(state.asLoading());

    try {
      // Call repository (async operation)
      await _repository.sendResetLink(email: email);
      emit(state.asSuccess());
    } on ForgotPasswordFailure catch (error) {
      // Typed error from repository
      emit(state.asFailure(error.message));
    } catch (error) {
      // Unexpected error
      emit(state.asFailure('Failed to send reset link. Please try again.'));
    }
  }

  /// Validate email before attempting password reset
  ///
  /// Returns error message if validation fails, null if valid
  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }

    if (!_isValidEmail(email)) {
      return 'Please enter a valid email address';
    }

    return null; // Valid
  }

  /// Basic email format validation
  bool _isValidEmail(String email) {
    // Simple email validation regex
    // In production, you might want to use a more robust validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Reset state to initial (useful for retry)
  void reset() {
    emit(const ForgotPasswordState.initial());
  }
}
