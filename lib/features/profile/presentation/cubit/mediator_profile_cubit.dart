import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/models/user_stats_model.dart';
import '../../data/models/listing_model.dart';
import '../../data/models/trade_history_model.dart';
import 'mediator_profile_state.dart';

/// MediatorProfileCubit - Cubit for managing mediator profile screen state
///
/// Handles loading and managing mediator profile data including:
/// - Stats (completed deals, rating, sold, bought)
/// - Listings
/// - Trade history
/// - Mediator-specific data (earnings, tier, performance)
class MediatorProfileCubit extends Cubit<MediatorProfileState> {
  final ProfileRepository profileRepository;

  MediatorProfileCubit(this.profileRepository) : super(const MediatorProfileState());

  /// Loads all mediator profile data
  Future<void> loadMediatorProfile() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final results = await Future.wait([
        profileRepository.getUserStats(),
        profileRepository.getUserListings(),
        profileRepository.getTradeHistory(),
      ]);

      emit(state.copyWith(
        isLoading: false,
        userStats: results[0] as UserStatsModel,
        listings: results[1] as List<ListingModel>,
        tradeHistory: results[2] as List<TradeHistoryModel>,
        // TODO: Load actual mediator-specific data from repository
        // For now, using mock values
        totalEarnings: 15250.00,
        mediatorTier: 'Gold',
        rating: 4.8,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load mediator profile: ${e.toString()}',
      ));
    }
  }

  /// Refreshes all profile data
  Future<void> refresh() async {
    await loadMediatorProfile();
  }

  /// Refreshes user stats only
  Future<void> refreshStats() async {
    try {
      final stats = await profileRepository.getUserStats();
      emit(state.copyWith(userStats: stats));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to refresh stats: ${e.toString()}'));
    }
  }

  /// Refreshes listings only
  Future<void> refreshListings() async {
    try {
      final listings = await profileRepository.getUserListings();
      emit(state.copyWith(listings: listings));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to refresh listings: ${e.toString()}'));
    }
  }

  /// Refreshes trade history only
  Future<void> refreshTradeHistory() async {
    try {
      final history = await profileRepository.getTradeHistory();
      emit(state.copyWith(tradeHistory: history));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to refresh trade history: ${e.toString()}'));
    }
  }
}
