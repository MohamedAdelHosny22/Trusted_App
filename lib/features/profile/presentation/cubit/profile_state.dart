import '../../data/models/user_stats_model.dart';
import '../../data/models/listing_model.dart';
import '../../data/models/trade_history_model.dart';

/// ProfileState - State for ProfileCubit
///
/// Immutable state representing the current status of profile data
class ProfileState {
  final bool isLoading;
  final String? errorMessage;
  final UserStatsModel? userStats;
  final List<ListingModel>? listings;
  final List<TradeHistoryModel>? tradeHistory;

  const ProfileState({
    this.isLoading = false,
    this.errorMessage,
    this.userStats,
    this.listings,
    this.tradeHistory,
  });

  ProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    UserStatsModel? userStats,
    List<ListingModel>? listings,
    List<TradeHistoryModel>? tradeHistory,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      userStats: userStats ?? this.userStats,
      listings: listings ?? this.listings,
      tradeHistory: tradeHistory ?? this.tradeHistory,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          errorMessage == other.errorMessage &&
          userStats == other.userStats &&
          listings == other.listings &&
          tradeHistory == other.tradeHistory;

  @override
  int get hashCode =>
      isLoading.hashCode ^
      errorMessage.hashCode ^
      userStats.hashCode ^
      listings.hashCode ^
      tradeHistory.hashCode;
}
