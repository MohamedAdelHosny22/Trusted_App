/// SignupRequest - User registration credentials model
class SignupRequest {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;
  final String ipAddress;
  final String phoneNumber;

  const SignupRequest({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
    required this.ipAddress,
    required this.phoneNumber,
  });

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'password': password,
      'ipAddress': ipAddress,
      'phoneNumber': phoneNumber,
    };
  }

  /// Create from JSON (for testing or caching)
  factory SignupRequest.fromJson(Map<String, dynamic> json) {
    return SignupRequest(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      ipAddress: json['ipAddress'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  @override
  String toString() {
    return 'SignupRequest(userName: $userName, email: $email, password: ***)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignupRequest &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.userName == userName &&
        other.email == email &&
        other.password == password &&
        other.ipAddress == ipAddress &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        password.hashCode ^
        ipAddress.hashCode ^
        phoneNumber.hashCode;
  }
}
