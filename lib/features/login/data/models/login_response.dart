import 'user_model.dart';

/// LoginResponse - Authentication response model
///
/// Contains user data and authentication token from successful login
class LoginResponse {
  final UserModel user;
  final String accessToken;
  final String? refreshToken;
  final int expiresIn; // seconds until token expires

  const LoginResponse({
    required this.user,
    required this.accessToken,
    this.refreshToken,
    required this.expiresIn,
  });

  /// Create from JSON (API response)
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
      expiresIn: json['expires_in'] as int,
    );
  }

  /// Convert to JSON (for testing or caching)
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
    };
  }

  /// Check if token is expired
  bool isTokenExpired() {
    // This is a simplified check
    // In production, you'd store the expiry timestamp and compare
    return false;
  }

  /// Create a mock response for testing
  factory LoginResponse.mock() {
    return LoginResponse(
      user: UserModel.mock(),
      accessToken: 'mock-access-token-12345',
      refreshToken: 'mock-refresh-token-67890',
      expiresIn: 3600, // 1 hour
    );
  }

  @override
  String toString() {
    return 'LoginResponse(user: $user, accessToken: ***, expiresIn: $expiresIn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginResponse &&
        other.user == user &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.expiresIn == expiresIn;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        accessToken.hashCode ^
        refreshToken.hashCode ^
        expiresIn.hashCode;
  }
}
