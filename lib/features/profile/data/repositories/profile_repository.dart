import '../models/user_stats_model.dart';
import '../models/listing_model.dart';
import '../models/trade_history_model.dart';

/// ProfileRepository - Repository interface for profile data
///
/// Abstract repository defining contract for profile data operations
abstract class ProfileRepository {
  /// Fetches user statistics from the backend API
  /// Future implementation: GET /api/user/stats
  Future<UserStatsModel> getUserStats();

  /// Fetches user's active listings
  /// Future implementation: GET /api/user/listings?status=active&limit=10
  Future<List<ListingModel>> getUserListings();

  /// Fetches user's recent trade history
  /// Future implementation: GET /api/user/trades?limit=10
  Future<List<TradeHistoryModel>> getTradeHistory();
}
