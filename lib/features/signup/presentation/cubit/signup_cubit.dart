import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/signup_repository.dart';
import 'signup_state.dart';

/// SignupCubit - State management for signup feature
///
/// Responsibilities:
/// - Validate user input
/// - Call repository for registration
/// - Emit state changes for UI to react
///
/// NOT responsible for:
/// - Navigation (UI handles this via BlocListener)
/// - Showing snackbars (UI handles this via BlocListener)
/// - Direct API calls (delegated to Repository)
class SignupCubit extends Cubit<SignupState> {
  final SignupRepository _repository;

  SignupCubit(this._repository) : super(const SignupState.initial());

  /// Register new user with credentials
  ///
  /// Validates input, calls repository, and emits appropriate states
  Future<void> signup({
    required String username,
    required String phone,
    required String email,
    required String password,
  }) async {
    // Validate input
    final validationResult = _validateSignupData(username, phone, email, password);
    if (validationResult != null) {
      emit(state.asFailure(validationResult));
      return;
    }

    // Emit loading state
    emit(state.asLoading());

    try {
      // Call repository (async operation)
      final user = await _repository.signup(
        username: username,
        phone: phone,
        email: email,
        password: password,
      );
      emit(state.asSuccess(user));
    } on SignupFailure catch (error) {
      // Typed error from repository
      emit(state.asFailure(error.message));
    } catch (error) {
      // Unexpected error
      emit(state.asFailure('Registration failed. Please try again.'));
    }
  }

  /// Validate signup data before attempting registration
  ///
  /// Returns error message if validation fails, null if valid
  String? _validateSignupData(String username, String phone, String email, String password) {
    // Username validation
    if (username.isEmpty) {
      return 'Username is required';
    }

    if (username.length < 3) {
      return 'Username must be at least 3 characters';
    }

    // Phone validation
    if (phone.isEmpty) {
      return 'Phone number is required';
    }

    if (phone.length < 10) {
      return 'Phone number must be at least 10 digits';
    }

    // Email validation
    if (email.isEmpty) {
      return 'Email is required';
    }

    if (!_isValidEmail(email)) {
      return 'Please enter a valid email address';
    }

    // Password validation
    if (password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
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
    emit(const SignupState.initial());
  }
}
