import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/models/user_stats_model.dart';
import '../../data/models/listing_model.dart';
import '../../data/models/trade_history_model.dart';
import 'profile_state.dart';

/// ProfileCubit - Cubit for managing profile screen state
///
/// Handles loading and managing user profile data including stats,
/// listings, and trade history
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ProfileCubit(this.profileRepository) : super(const ProfileState());

  /// Loads all profile data (stats, listings, trade history)
  Future<void> loadProfileData() async {
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
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load profile data: ${e.toString()}',
      ));
    }
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
      final tradeHistory = await profileRepository.getTradeHistory();
      emit(state.copyWith(tradeHistory: tradeHistory));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to refresh trade history: ${e.toString()}'));
    }
  }

  /// Refreshes all profile data
  Future<void> refresh() => loadProfileData();
}
