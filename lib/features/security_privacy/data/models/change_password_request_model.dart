/// ChangePasswordRequestModel - Password change request
///
/// Encapsulates current password and new password for password change requests
class ChangePasswordRequestModel {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordRequestModel({
    required this.currentPassword,
    required this.newPassword,
  });

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'current_password': currentPassword,
      'new_password': newPassword,
    };
  }

  /// Create from JSON (for testing)
  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordRequestModel(
      currentPassword: json['current_password'] as String,
      newPassword: json['new_password'] as String,
    );
  }

  @override
  String toString() {
    return 'ChangePasswordRequestModel(currentPassword: ***, newPassword: ***)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChangePasswordRequestModel &&
        other.currentPassword == currentPassword &&
        other.newPassword == newPassword;
  }

  @override
  int get hashCode => currentPassword.hashCode ^ newPassword.hashCode;
}
