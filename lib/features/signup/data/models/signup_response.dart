import 'package:trusted_app/features/login/data/models/user_model.dart';

/// SignupResponse - Registration response model
class SignupResponse {
  final bool isSuccess;
  final String? arRes;
  final String? enRes;
  final UserModel? user;
  final String? accessToken;
  final DateTime? expiresAt;
  final int statusCode;
  final List<dynamic>? errors;

  const SignupResponse({
    required this.isSuccess,
    this.arRes,
    this.enRes,
    this.user,
    this.accessToken,
    this.expiresAt,
    required this.statusCode,
    this.errors,
  });

  /// Create from JSON (API response parsing)
  factory SignupResponse.fromJson(Map<String, dynamic> json) {
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
      );
    }

    return SignupResponse(
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

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'arRes': arRes,
      'enRes': enRes,
      'data': user != null ? {
        'token': accessToken,
        'expiresAt': expiresAt?.toIso8601String(),
        'email': user?.email,
      } : null,
      'statusCode': statusCode,
      'errors': errors,
    };
  }

  /// Mock successful signup response
  factory SignupResponse.mock() {
    return SignupResponse(
      isSuccess: true,
      enRes: 'Account created successfully',
      user: UserModel.mock(),
      statusCode: 200,
      accessToken: 'mock_token_123',
    );
  }

  @override
  String toString() {
    return 'SignupResponse(isSuccess: $isSuccess, enRes: $enRes, user: $user)';
  }
}
