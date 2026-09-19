import '../../data/models/user_stats_model.dart';
import '../../data/models/listing_model.dart';
import '../../data/models/trade_history_model.dart';

/// MediatorProfileState - State for MediatorProfileCubit
///
/// Immutable state representing the current status of mediator profile data
/// Extends regular profile state with mediator-specific fields
class MediatorProfileState {
  final bool isLoading;
  final String? errorMessage;
  final UserStatsModel? userStats;
  final List<ListingModel>? listings;
  final List<TradeHistoryModel>? tradeHistory;

  // Mediator-specific fields
  final double? totalEarnings;
  final String? mediatorTier;
  final double? rating;

  const MediatorProfileState({
    this.isLoading = false,
    this.errorMessage,
    this.userStats,
    this.listings,
    this.tradeHistory,
    this.totalEarnings,
    this.mediatorTier,
    this.rating,
  });

  MediatorProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    UserStatsModel? userStats,
    List<ListingModel>? listings,
    List<TradeHistoryModel>? tradeHistory,
    double? totalEarnings,
    String? mediatorTier,
    double? rating,
  }) {
    return MediatorProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      userStats: userStats ?? this.userStats,
      listings: listings ?? this.listings,
      tradeHistory: tradeHistory ?? this.tradeHistory,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      mediatorTier: mediatorTier ?? this.mediatorTier,
      rating: rating ?? this.rating,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediatorProfileState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          errorMessage == other.errorMessage &&
          userStats == other.userStats &&
          listings == other.listings &&
          tradeHistory == other.tradeHistory &&
          totalEarnings == other.totalEarnings &&
          mediatorTier == other.mediatorTier &&
          rating == other.rating;

  @override
  int get hashCode =>
      isLoading.hashCode ^
      errorMessage.hashCode ^
      userStats.hashCode ^
      listings.hashCode ^
      tradeHistory.hashCode ^
      totalEarnings.hashCode ^
      mediatorTier.hashCode ^
      rating.hashCode;
}
