/// UserRole - User role enumeration
///
/// Defines the different roles a user can have in the system
enum UserRole {
  /// Regular user - can buy and sell accounts
  user,

  /// Mediator - trusted intermediary for secure transactions
  /// Mediators are pre-defined and cannot sign up publicly
  mediator,

  /// Admin - system administrator (reserved for future use)
  admin,
}

/// UserRoleExtension - Extension for UserRole utility methods
extension UserRoleExtension on UserRole {
  /// Get display name for the role
  String get displayName {
    switch (this) {
      case UserRole.user:
        return 'User';
      case UserRole.mediator:
        return 'Mediator';
      case UserRole.admin:
        return 'Admin';
    }
  }

  /// Check if user is mediator
  bool get isMediator => this == UserRole.mediator;

  /// Check if user is admin
  bool get isAdmin => this == UserRole.admin;

  /// Check if user is regular user
  bool get isRegularUser => this == UserRole.user;

  /// Convert from string
  static UserRole fromString(String role) {
    return UserRole.values.firstWhere(
      (e) => e.name == role.toLowerCase(),
      orElse: () => UserRole.user,
    );
  }
}
