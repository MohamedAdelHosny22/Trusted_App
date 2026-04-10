import '../models/user_model.dart';
import '../models/login_request.dart';
import '../data_sources/login_remote_data_source.dart';

/// LoginRepository - Authentication repository interface
///
/// Abstract contract for authentication operations
/// Follows Dependency Inversion Principle (high-level modules depend on abstractions)
abstract class LoginRepository {
  /// Authenticate user with username and password
  ///
  /// Returns [UserModel] on success
  /// Throws [LoginFailure] if authentication fails
  Future<UserModel> login({
    required String username,
    required String password,
  });
}

/// LoginRepositoryImpl - Concrete implementation
///
/// Coordinates between data source and domain layer
/// Handles data transformation and error mapping
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _remoteDataSource;

  LoginRepositoryImpl({
    required LoginRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    try {
      // Call remote data source
      final response = await _remoteDataSource.login(
        LoginRequest(
          username: username,
          password: password,
        ),
      );

      // Extract user data from response
      // In production, you might want to store tokens here
      return response.user;
    } on LoginFailure {
      // Re-throw typed errors
      rethrow;
    } catch (e) {
      // Wrap unexpected errors
      throw LoginFailure('Authentication service error: $e');
    }
  }
}

/// LoginFailure - Authentication error
///
/// Typed exception for authentication failures
/// Allows repository to communicate specific error messages to presentation layer
class LoginFailure implements Exception {
  final String message;

  const LoginFailure(this.message);

  @override
  String toString() => 'LoginFailure: $message';
}
