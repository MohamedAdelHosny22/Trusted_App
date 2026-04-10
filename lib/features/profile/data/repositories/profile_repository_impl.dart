import '../models/user_stats_model.dart';
import '../models/listing_model.dart';
import '../models/trade_history_model.dart';
import 'profile_repository.dart';

/// ProfileRepositoryImpl - Mock implementation of ProfileRepository
///
/// TODO: Replace with actual API integration
/// This implementation provides mock data matching the Figma design
class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<UserStatsModel> getUserStats() async {
    // TODO: Replace with actual API call
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data matching Figma design specs
    return UserStatsModel.mock();
  }

  @override
  Future<List<ListingModel>> getUserListings() async {
    // TODO: Replace with actual API call
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Mock data with multiple listings matching Figma design
    return ListingModel.mockListings();
  }

  @override
  Future<List<TradeHistoryModel>> getTradeHistory() async {
    // TODO: Replace with actual API call
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    // Mock data with varied statuses matching Figma design
    return TradeHistoryModel.mockTradeHistory();
  }
}
