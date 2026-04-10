/// SignupRequest - User registration credentials model
///
/// Encapsulates username, phone, email, and password for registration requests
class SignupRequest {
  final String username;
  final String phone;
  final String email;
  final String password;

  const SignupRequest({
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
  });

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'phone': phone,
      'email': email,
      'password': password,
    };
  }

  /// Create from JSON (for testing or caching)
  factory SignupRequest.fromJson(Map<String, dynamic> json) {
    return SignupRequest(
      username: json['username'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  @override
  String toString() {
    return 'SignupRequest(username: $username, phone: $phone, email: $email, password: ***)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignupRequest &&
        other.username == username &&
        other.phone == phone &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ phone.hashCode ^ email.hashCode ^ password.hashCode;
}
