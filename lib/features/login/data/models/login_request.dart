/// LoginRequest - Login credentials model
///
/// Encapsulates username and password for authentication requests
class LoginRequest {
  final String email;
  final String password;
  final String ipAddress;

  const LoginRequest({
    required this.email,
    required this.password,
    required this.ipAddress,
  });

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'ipAddress': ipAddress,
    };
  }

  /// Create from JSON (for testing or caching)
  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      ipAddress: json['ipAddress'] as String,
    );
  }

  @override
  String toString() {
    return 'LoginRequest(email: $email, password: ***, ipAddress: $ipAddress)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginRequest &&
        other.email == email &&
        other.password == password &&
        other.ipAddress == ipAddress;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ ipAddress.hashCode;
}
