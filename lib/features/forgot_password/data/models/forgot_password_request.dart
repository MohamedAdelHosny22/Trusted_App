/// ForgotPasswordRequest - Password reset request model
///
/// Encapsulates email for password reset requests
class ForgotPasswordRequest {
  final String email;

  const ForgotPasswordRequest({
    required this.email,
  });

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  /// Create from JSON (for testing or caching)
  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordRequest(
      email: json['email'] as String,
    );
  }

  @override
  String toString() {
    return 'ForgotPasswordRequest(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ForgotPasswordRequest && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}
