import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/login_repository.dart';
import 'login_state.dart';

/// LoginCubit - State management for login feature
///
/// Responsibilities:
/// - Validate user input
/// - Call repository for authentication
/// - Emit state changes for UI to react
///
/// NOT responsible for:
/// - Navigation (UI handles this via BlocListener)
/// - Showing snackbars (UI handles this via BlocListener)
/// - Direct API calls (delegated to Repository)
class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _repository;

  LoginCubit(this._repository) : super(const LoginState.initial());

  /// Authenticate user with username and password
  ///
  /// Validates input, calls repository, and emits appropriate states
  Future<void> login({
    required String username,
    required String password,
  }) async {
    // Validate input
    final validationResult = _validateCredentials(username, password);
    if (validationResult != null) {
      emit(state.asFailure(validationResult));
      return;
    }

    // Emit loading state
    emit(state.asLoading());

    try {
      // Call repository (async operation)
      final user = await _repository.login(
        username: username,
        password: password,
      );
      emit(state.asSuccess(user));
    } on LoginFailure catch (error) {
      // Typed error from repository
      emit(state.asFailure(error.message));
    } catch (error) {
      // Unexpected error
      emit(state.asFailure('Login failed. Please try again.'));
    }
  }

  /// Validate username and password before attempting login
  ///
  /// Returns error message if validation fails, null if valid
  String? _validateCredentials(String username, String password) {
    if (username.isEmpty) {
      return 'Username is required';
    }

    if (username.length < 3) {
      return 'Username must be at least 3 characters';
    }

    if (password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null; // Valid
  }

  /// Reset state to initial (useful for retry)
  void reset() {
    emit(const LoginState.initial());
  }
}
