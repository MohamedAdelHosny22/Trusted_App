import 'package:trusted_app/features/login/data/models/user_model.dart';

import '../models/signup_request.dart';
import '../data_sources/signup_remote_data_source.dart';

/// SignupRepository - Registration repository interface
///
/// Abstract contract for registration operations
/// Follows Dependency Inversion Principle (high-level modules depend on abstractions)
abstract class SignupRepository {
  /// Register new user with credentials
  ///
  /// Returns [UserModel] on success
  /// Throws [SignupFailure] if registration fails
  Future<UserModel> signup({
    required String username,
    required String phone,
    required String email,
    required String password,
  });
}

/// SignupRepositoryImpl - Concrete implementation
///
/// Coordinates between data source and domain layer
/// Handles data transformation and error mapping
class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDataSource _remoteDataSource;

  SignupRepositoryImpl({
    required SignupRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<UserModel> signup({
    required String username,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      // Call remote data source
      final response = await _remoteDataSource.signup(
        SignupRequest(
          username: username,
          phone: phone,
          email: email,
          password: password,
        ),
      );

      // Extract user data from response
      // In production, you might want to store tokens here
      return response.user;
    } on SignupFailure {
      // Re-throw typed errors
      rethrow;
    } catch (e) {
      // Wrap unexpected errors
      throw SignupFailure('Registration service error: $e');
    }
  }
}

/// SignupFailure - Registration error
///
/// Typed exception for registration failures
/// Allows repository to communicate specific error messages to presentation layer
class SignupFailure implements Exception {
  final String message;

  const SignupFailure(this.message);

  @override
  String toString() => 'SignupFailure: $message';
}
