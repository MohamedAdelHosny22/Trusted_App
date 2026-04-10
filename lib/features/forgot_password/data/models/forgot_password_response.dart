/// ForgotPasswordResponse - Password reset response model
///
/// Encapsulates response data for password reset requests
class ForgotPasswordResponse {
  final String message;
  final bool success;

  const ForgotPasswordResponse({
    required this.message,
    required this.success,
  });

  /// Mock successful password reset response
  factory ForgotPasswordResponse.mock() {
    return const ForgotPasswordResponse(
      message: 'Password reset link sent to your email',
      success: true,
    );
  }

  /// Create from JSON (for API response parsing)
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      message: json['message'] as String,
      success: json['success'] as bool,
    );
  }

  /// Convert to JSON (for testing)
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
    };
  }

  @override
  String toString() {
    return 'ForgotPasswordResponse(message: $message, success: $success)';
  }
}
