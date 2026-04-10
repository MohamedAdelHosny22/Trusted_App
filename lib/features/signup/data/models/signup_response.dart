import 'package:trusted_app/features/login/data/models/user_model.dart';

/// SignupResponse - Registration response model
///
/// Encapsulates user data returned after successful registration
class SignupResponse {
  final UserModel user;
  final String message;

  const SignupResponse({
    required this.user,
    required this.message,
  });

  /// Mock successful signup response
  factory SignupResponse.mock() {
    return SignupResponse(
      user: UserModel.mock(),
      message: 'Account created successfully',
    );
  }

  /// Create from JSON (for API response parsing)
  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }

  /// Convert to JSON (for testing)
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'message': message,
    };
  }

  @override
  String toString() {
    return 'SignupResponse(user: $user, message: $message)';
  }
}
