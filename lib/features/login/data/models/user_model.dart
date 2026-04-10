/// UserModel - User data entity
///
/// Represents user information returned after successful authentication
class UserModel {
  final String id;
  final String username;
  final String? email;
  final String? displayName;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.username,
    this.email,
    this.displayName,
    this.createdAt,
  });

  /// Create UserModel from JSON (API response)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String?,
      displayName: json['display_name'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  /// Convert UserModel to JSON (for API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'display_name': displayName,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  /// CopyWith for immutable updates
  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? displayName,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Create a mock user for testing
  factory UserModel.mock() {
    return const UserModel(
      id: 'mock-user-123',
      username: 'testuser',
      email: 'test@example.com',
      displayName: 'Test User',
      createdAt: null,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.username == username &&
        other.email == email &&
        other.displayName == displayName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        displayName.hashCode;
  }
}
