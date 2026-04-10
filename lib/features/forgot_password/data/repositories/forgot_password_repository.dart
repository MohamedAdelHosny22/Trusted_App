import '../models/forgot_password_request.dart';
import '../data_sources/forgot_password_remote_data_source.dart';

/// ForgotPasswordRepository - Password reset repository interface
///
/// Abstract contract for password reset operations
/// Follows Dependency Inversion Principle (high-level modules depend on abstractions)
abstract class ForgotPasswordRepository {
  /// Request password reset link for email
  ///
  /// Returns success message on success
  /// Throws [ForgotPasswordFailure] if request fails
  Future<String> sendResetLink({
    required String email,
  });
}

/// ForgotPasswordRepositoryImpl - Concrete implementation
///
/// Coordinates between data source and domain layer
/// Handles data transformation and error mapping
class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordRemoteDataSource _remoteDataSource;

  ForgotPasswordRepositoryImpl({
    required ForgotPasswordRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<String> sendResetLink({
    required String email,
  }) async {
    try {
      // Call remote data source
      final response = await _remoteDataSource.sendResetLink(
        ForgotPasswordRequest(email: email),
      );

      // Return success message
      return response.message;
    } on ForgotPasswordFailure {
      // Re-throw typed errors
      rethrow;
    } catch (e) {
      // Wrap unexpected errors
      throw ForgotPasswordFailure('Password reset service error: $e');
    }
  }
}

/// ForgotPasswordFailure - Password reset error
///
/// Typed exception for password reset failures
/// Allows repository to communicate specific error messages to presentation layer
class ForgotPasswordFailure implements Exception {
  final String message;

  const ForgotPasswordFailure(this.message);

  @override
  String toString() => 'ForgotPasswordFailure: $message';
}
