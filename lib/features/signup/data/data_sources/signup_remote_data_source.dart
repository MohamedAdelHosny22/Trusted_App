import '../models/signup_request.dart';
import '../models/signup_response.dart';
import '../repositories/signup_repository.dart';

/// SignupRemoteDataSource - Registration data source interface
///
/// Abstract contract for remote registration operations
/// Implementations can use HTTP, Firebase, or any other auth service
abstract class SignupRemoteDataSource {
  /// Register new user with credentials
  ///
  /// Throws [SignupFailure] if registration fails
  Future<SignupResponse> signup(SignupRequest request);
}

/// SignupRemoteDataSourceImpl - HTTP implementation
///
/// Mock implementation simulates API call with delay
/// In production, replace with actual HTTP client (dio, http, etc.)
class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  // Simulated network delay
  static const Duration _networkDelay = Duration(seconds: 2);

  const SignupRemoteDataSourceImpl();

  @override
  Future<SignupResponse> signup(SignupRequest request) async {
    // Simulate network delay
    await Future.delayed(_networkDelay);

    // Mock registration logic
    // In production, this would be an actual API call
    if (_isValidSignupData(request)) {
      return SignupResponse.mock();
    } else {
      throw const SignupFailure('Registration failed. Please try again.');
    }
  }

  /// Validate signup data (mock implementation)
  ///
  /// In production, this is handled by the API
  bool _isValidSignupData(SignupRequest request) {
    // Mock validation: accept any valid format
    return request.username.length >= 3 &&
        request.phone.length >= 10 &&
        request.email.contains('@') &&
        request.password.length >= 6;
  }
}

/// SignupRemoteDataSourceImpl - Production HTTP implementation example
///
/// This is commented out as an example for when you integrate a real API
/*
class SignupRemoteDataSourceImplHttp implements SignupRemoteDataSource {
  final Dio _dio;
  final String baseUrl;

  SignupRemoteDataSourceImplHttp({
    required String baseUrl,
    Dio? dio,
  })  : _dio = dio ?? Dio(),
        baseUrl = baseUrl;

  @override
  Future<SignupResponse> signup(SignupRequest request) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/signup',
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return SignupResponse.fromJson(response.data);
      } else {
        throw const SignupFailure('Registration failed');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw const SignupFailure('Invalid input data');
      } else if (e.response?.statusCode == 409) {
        throw const SignupFailure('User already exists');
      } else if (e.response?.statusCode == 500) {
        throw const SignupFailure('Server error. Please try again later.');
      } else {
        throw const SignupFailure('Network error. Please check your connection.');
      }
    } catch (e) {
      throw const SignupFailure('An unexpected error occurred');
    }
  }
}
*/
