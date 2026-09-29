import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/signup_repository.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepository _repository;

  SignupCubit(this._repository) : super(const SignupState.initial());

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    final validationResult = _validateSignupData(
      firstName,
      lastName,
      userName,
      email,
      password,
      phoneNumber,
    );

    if (validationResult != null) {
      emit(state.asFailure(validationResult));
      return;
    }

    emit(state.asLoading());

    try {
      final user = await _repository.signup(
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
      emit(state.asSuccess(user));
    } on SignupFailure catch (error) {
      emit(state.asFailure(error.message));
    } catch (error) {
      emit(state.asFailure('Registration failed. Please try again.'));
    }
  }

  String? _validateSignupData(
    String firstName,
    String lastName,
    String userName,
    String email,
    String password,
    String phoneNumber,
  ) {
    if (firstName.trim().isEmpty) {
      return 'First name is required';
    }

    if (lastName.trim().isEmpty) {
      return 'Last name is required';
    }

    if (userName.trim().isEmpty) {
      return 'Username is required';
    }

    if (userName.length < 3) {
      return 'Username must be at least 3 characters';
    }

    if (email.trim().isEmpty) {
      return 'Email is required';
    }

    if (!email.trim().toLowerCase().endsWith('@gmail.com')) {
      return 'Currently, only @gmail.com email addresses are supported.';
    }

    if (password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (phoneNumber.trim().isEmpty) {
      return 'Phone number is required';
    }

    return null; // Valid
  }

  void reset() {
    emit(const SignupState.initial());
  }
}
