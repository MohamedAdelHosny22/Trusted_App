/// MediatorStatsModel - Statistics for a mediator
///
/// Tracks mediator performance metrics
class MediatorStatsModel {
  final int pendingRequests;
  final int completedTransactions;
  final int totalTransactions;
  final double rating;
  final int totalReviews;
  final double earnings; // Total earnings from mediation fees
  final DateTime lastUpdated;

  const MediatorStatsModel({
    required this.pendingRequests,
    required this.completedTransactions,
    required this.totalTransactions,
    required this.rating,
    required this.totalReviews,
    required this.earnings,
    required this.lastUpdated,
  });

  factory MediatorStatsModel.fromJson(Map<String, dynamic> json) {
    return MediatorStatsModel(
      pendingRequests: json['pending_requests'] as int,
      completedTransactions: json['completed_transactions'] as int,
      totalTransactions: json['total_transactions'] as int,
      rating: (json['rating'] as num).toDouble(),
      totalReviews: json['total_reviews'] as int,
      earnings: (json['earnings'] as num).toDouble(),
      lastUpdated: DateTime.parse(json['last_updated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pending_requests': pendingRequests,
      'completed_transactions': completedTransactions,
      'total_transactions': totalTransactions,
      'rating': rating,
      'total_reviews': totalReviews,
      'earnings': earnings,
      'last_updated': lastUpdated.toIso8601String(),
    };
  }

  /// Calculate approval rate
  double get approvalRate {
    if (totalTransactions == 0) return 0.0;
    return completedTransactions / totalTransactions;
  }

  MediatorStatsModel copyWith({
    int? pendingRequests,
    int? completedTransactions,
    int? totalTransactions,
    double? rating,
    int? totalReviews,
    double? earnings,
    DateTime? lastUpdated,
  }) {
    return MediatorStatsModel(
      pendingRequests: pendingRequests ?? this.pendingRequests,
      completedTransactions: completedTransactions ?? this.completedTransactions,
      totalTransactions: totalTransactions ?? this.totalTransactions,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      earnings: earnings ?? this.earnings,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Create empty stats for initialization
  factory MediatorStatsModel.empty() {
    return MediatorStatsModel(
      pendingRequests: 0,
      completedTransactions: 0,
      totalTransactions: 0,
      rating: 0.0,
      totalReviews: 0,
      earnings: 0.0,
      lastUpdated: DateTime.now(),
    );
  }

  /// Create mock stats for testing
  factory MediatorStatsModel.mock() {
    return MediatorStatsModel(
      pendingRequests: 5,
      completedTransactions: 1520,
      totalTransactions: 1589,
      rating: 4.9,
      totalReviews: 1520,
      earnings: 45600.0,
      lastUpdated: DateTime.now(),
    );
  }
}
