/// SecuritySettingsModel - User security and privacy settings
///
/// Encapsulates security-related user preferences and settings
class SecuritySettingsModel {
  final bool twoFactorEnabled;
  final bool biometricEnabled;
  final bool loginNotificationsEnabled;
  final String lastPasswordChange;
  final bool emailVerified;

  const SecuritySettingsModel({
    required this.twoFactorEnabled,
    required this.biometricEnabled,
    required this.loginNotificationsEnabled,
    required this.lastPasswordChange,
    required this.emailVerified,
  });

  /// Create from JSON (API response)
  factory SecuritySettingsModel.fromJson(Map<String, dynamic> json) {
    return SecuritySettingsModel(
      twoFactorEnabled: json['two_factor_enabled'] as bool? ?? false,
      biometricEnabled: json['biometric_enabled'] as bool? ?? false,
      loginNotificationsEnabled: json['login_notifications_enabled'] as bool? ?? true,
      lastPasswordChange: json['last_password_change'] as String? ?? '',
      emailVerified: json['email_verified'] as bool? ?? false,
    );
  }

  /// Convert to JSON (for API requests)
  Map<String, dynamic> toJson() {
    return {
      'two_factor_enabled': twoFactorEnabled,
      'biometric_enabled': biometricEnabled,
      'login_notifications_enabled': loginNotificationsEnabled,
      'last_password_change': lastPasswordChange,
      'email_verified': emailVerified,
    };
  }

  /// CopyWith for immutable updates
  SecuritySettingsModel copyWith({
    bool? twoFactorEnabled,
    bool? biometricEnabled,
    bool? loginNotificationsEnabled,
    String? lastPasswordChange,
    bool? emailVerified,
  }) {
    return SecuritySettingsModel(
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      loginNotificationsEnabled: loginNotificationsEnabled ?? this.loginNotificationsEnabled,
      lastPasswordChange: lastPasswordChange ?? this.lastPasswordChange,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }

  @override
  String toString() {
    return 'SecuritySettingsModel(twoFactor: $twoFactorEnabled, biometric: $biometricEnabled, notifications: $loginNotificationsEnabled)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SecuritySettingsModel &&
        other.twoFactorEnabled == twoFactorEnabled &&
        other.biometricEnabled == biometricEnabled &&
        other.loginNotificationsEnabled == loginNotificationsEnabled &&
        other.lastPasswordChange == lastPasswordChange &&
        other.emailVerified == emailVerified;
  }

  @override
  int get hashCode {
    return twoFactorEnabled.hashCode ^
        biometricEnabled.hashCode ^
        loginNotificationsEnabled.hashCode ^
        lastPasswordChange.hashCode ^
        emailVerified.hashCode;
  }
}
