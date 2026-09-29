import 'user_model.dart';
import '../../../../core/models/user_role.dart';

/// LoginResponse - Authentication response model
class LoginResponse {
  final bool isSuccess;
  final String? arRes;
  final String? enRes;
  final UserModel? user;
  final String? accessToken;
  final DateTime? expiresAt;
  final int statusCode;
  final List<dynamic>? errors;

  const LoginResponse({
    required this.isSuccess,
    this.arRes,
    this.enRes,
    this.user,
    this.accessToken,
    this.expiresAt,
    required this.statusCode,
    this.errors,
  });

  /// Create from JSON (API response)
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    UserModel? user;
    String? token;
    DateTime? expAt;

    if (json['data'] != null) {
      final data = json['data'] as Map<String, dynamic>;
      token = data['token'] as String?;
      if (data['expiresAt'] != null) {
        expAt = DateTime.tryParse(data['expiresAt'] as String);
      }
      
      user = UserModel(
        email: data['email'] as String?,
        role: data['role'] != null 
            ? UserRoleExtension.fromString(data['role'] as String) 
            : UserRole.user,
      );
    }

    return LoginResponse(
      isSuccess: json['isSuccess'] == true,
      arRes: json['arRes'] as String?,
      enRes: json['enRes'] as String?,
      user: user,
      accessToken: token,
      expiresAt: expAt,
      statusCode: json['statusCode'] as int? ?? 200,
      errors: json['errors'] as List<dynamic>?,
    );
  }

  /// Convert to JSON (for testing or caching)
  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'arRes': arRes,
      'enRes': enRes,
      'data': user != null ? {
        'token': accessToken,
        'expiresAt': expiresAt?.toIso8601String(),
        'email': user?.email,
        'role': user?.role.name,
      } : null,
      'statusCode': statusCode,
      'errors': errors,
    };
  }

  /// Check if token is expired
  bool isTokenExpired() {
    if (expiresAt == null) return true;
    return DateTime.now().isAfter(expiresAt!);
  }

  /// Create a mock response for testing
  factory LoginResponse.mock() {
    return LoginResponse(
      isSuccess: true,
      arRes: 'تم تسجيل الدخول بنجاح',
      enRes: 'Login successful.',
      user: UserModel.mock(),
      accessToken: 'mock-access-token-12345',
      expiresAt: DateTime.now().add(const Duration(days: 1)),
      statusCode: 200,
      errors: [],
    );
  }

  @override
  String toString() {
    return 'LoginResponse(isSuccess: $isSuccess, user: $user, accessToken: ***)';
  }
}
