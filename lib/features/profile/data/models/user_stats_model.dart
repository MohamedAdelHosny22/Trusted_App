import 'dart:convert';

/// UserStatsModel - User statistics for profile screen
///
/// Represents user's trading statistics including completed deals,
/// rating, accounts sold, and bought count.
class UserStatsModel {
  final int completedDeals;
  final double rating;
  final int accountsSold;
  final int boughtCount;

  const UserStatsModel({
    required this.completedDeals,
    required this.rating,
    required this.accountsSold,
    required this.boughtCount,
  });

  /// Creates UserStatsModel from JSON map
  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      completedDeals: json['completedDeals'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      accountsSold: json['accountsSold'] as int? ?? 0,
      boughtCount: json['boughtCount'] as int? ?? 0,
    );
  }

  /// Creates UserStatsModel from JSON string
  factory UserStatsModel.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return UserStatsModel.fromJson(json);
  }

  /// Converts UserStatsModel to JSON map
  Map<String, dynamic> toJson() {
    return {
      'completedDeals': completedDeals,
      'rating': rating,
      'accountsSold': accountsSold,
      'boughtCount': boughtCount,
    };
  }

  /// Converts UserStatsModel to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  /// Creates mock data matching Figma design
  factory UserStatsModel.mock() {
    return const UserStatsModel(
      completedDeals: 42,
      rating: 4.9,
      accountsSold: 15,
      boughtCount: 27,
    );
  }

  UserStatsModel copyWith({
    int? completedDeals,
    double? rating,
    int? accountsSold,
    int? boughtCount,
  }) {
    return UserStatsModel(
      completedDeals: completedDeals ?? this.completedDeals,
      rating: rating ?? this.rating,
      accountsSold: accountsSold ?? this.accountsSold,
      boughtCount: boughtCount ?? this.boughtCount,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStatsModel &&
          runtimeType == other.runtimeType &&
          completedDeals == other.completedDeals &&
          rating == other.rating &&
          accountsSold == other.accountsSold &&
          boughtCount == other.boughtCount;

  @override
  int get hashCode =>
      completedDeals.hashCode ^
      rating.hashCode ^
      accountsSold.hashCode ^
      boughtCount.hashCode;
}
