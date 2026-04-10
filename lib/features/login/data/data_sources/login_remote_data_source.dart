import '../models/login_request.dart';
import '../models/login_response.dart';
import '../repositories/login_repository.dart';

/// LoginRemoteDataSource - Authentication data source interface
///
/// Abstract contract for remote authentication operations
/// Implementations can use HTTP, Firebase, or any other auth service
abstract class LoginRemoteDataSource {
  /// Authenticate user with credentials
  ///
  /// Throws [LoginFailure] if authentication fails
  Future<LoginResponse> login(LoginRequest request);
}

/// LoginRemoteDataSourceImpl - HTTP implementation
///
/// Mock implementation simulates API call with delay
/// In production, replace with actual HTTP client (dio, http, etc.)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  // Simulated network delay
  static const Duration _networkDelay = Duration(seconds: 2);

  const LoginRemoteDataSourceImpl();

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    // Simulate network delay
    await Future.delayed(_networkDelay);

    // Mock authentication logic
    // In production, this would be an actual API call
    if (_isValidCredentials(request.username, request.password)) {
      return LoginResponse.mock();
    } else {
      throw const LoginFailure('Invalid username or password');
    }
  }

  /// Validate credentials (mock implementation)
  ///
  /// In production, this is handled by the API
  bool _isValidCredentials(String username, String password) {
    // Mock validation: accept any valid format
    return username.length >= 3 && password.length >= 6;
  }
}

/// LoginRemoteDataSourceImpl - Production HTTP implementation example
///
/// This is commented out as an example for when you integrate a real API
/*
class LoginRemoteDataSourceImplHttp implements LoginRemoteDataSource {
  final Dio _dio;
  final String baseUrl;

  LoginRemoteDataSourceImplHttp({
    required String baseUrl,
    Dio? dio,
  })  : _dio = dio ?? Dio(),
        baseUrl = baseUrl;

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/login',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw LoginFailure('Authentication failed');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const LoginFailure('Invalid username or password');
      } else if (e.response?.statusCode == 500) {
        throw const LoginFailure('Server error. Please try again later.');
      } else {
        throw const LoginFailure('Network error. Please check your connection.');
      }
    } catch (e) {
      throw const LoginFailure('An unexpected error occurred');
    }
  }
}
*/
