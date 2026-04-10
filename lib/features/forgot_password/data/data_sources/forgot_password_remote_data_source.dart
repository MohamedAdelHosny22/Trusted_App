import '../models/forgot_password_request.dart';
import '../models/forgot_password_response.dart';
import '../repositories/forgot_password_repository.dart';

/// ForgotPasswordRemoteDataSource - Password reset data source interface
///
/// Abstract contract for remote password reset operations
/// Implementations can use HTTP, Firebase, or any other auth service
abstract class ForgotPasswordRemoteDataSource {
  /// Request password reset for email
  ///
  /// Throws [ForgotPasswordFailure] if request fails
  Future<ForgotPasswordResponse> sendResetLink(ForgotPasswordRequest request);
}

/// ForgotPasswordRemoteDataSourceImpl - HTTP implementation
///
/// Mock implementation simulates API call with delay
/// In production, replace with actual HTTP client (dio, http, etc.)
class ForgotPasswordRemoteDataSourceImpl implements ForgotPasswordRemoteDataSource {
  // Simulated network delay
  static const Duration _networkDelay = Duration(seconds: 2);

  const ForgotPasswordRemoteDataSourceImpl();

  @override
  Future<ForgotPasswordResponse> sendResetLink(ForgotPasswordRequest request) async {
    // Simulate network delay
    await Future.delayed(_networkDelay);

    // Mock password reset logic
    // In production, this would be an actual API call
    if (_isValidEmail(request.email)) {
      return ForgotPasswordResponse.mock();
    } else {
      throw const ForgotPasswordFailure('Failed to send reset link. Please try again.');
    }
  }

  /// Validate email format (mock implementation)
  ///
  /// In production, this is handled by the API
  bool _isValidEmail(String email) {
    // Simple validation: check if email contains @
    return email.contains('@');
  }
}

/// ForgotPasswordRemoteDataSourceImpl - Production HTTP implementation example
///
/// This is commented out as an example for when you integrate a real API
/*
class ForgotPasswordRemoteDataSourceImplHttp implements ForgotPasswordRemoteDataSource {
  final Dio _dio;
  final String baseUrl;

  ForgotPasswordRemoteDataSourceImplHttp({
    required String baseUrl,
    Dio? dio,
  })  : _dio = dio ?? Dio(),
        baseUrl = baseUrl;

  @override
  Future<ForgotPasswordResponse> sendResetLink(ForgotPasswordRequest request) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/forgot-password',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return ForgotPasswordResponse.fromJson(response.data);
      } else {
        throw const ForgotPasswordFailure('Failed to send reset link');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw const ForgotPasswordFailure('Invalid email address');
      } else if (e.response?.statusCode == 404) {
        throw const ForgotPasswordFailure('Email not found');
      } else if (e.response?.statusCode == 500) {
        throw const ForgotPasswordFailure('Server error. Please try again later.');
      } else {
        throw const ForgotPasswordFailure('Network error. Please check your connection.');
      }
    } catch (e) {
      throw const ForgotPasswordFailure('An unexpected error occurred');
    }
  }
}
*/
