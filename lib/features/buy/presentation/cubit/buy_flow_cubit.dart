import 'package:flutter_bloc/flutter_bloc.dart';
import 'buy_flow_state.dart';
import '../../data/models/buy_account_model.dart';
import '../../data/models/buy_mediator_model.dart';

/// BuyFlowCubit - Cubit for managing the complete Buy flow
///
/// Handles:
/// - Loading accounts and mediators
/// - Selecting account and mediator
/// - Submitting payment proof
/// - Managing waiting state
class BuyFlowCubit extends Cubit<BuyFlowState> {
  BuyFlowCubit() : super(const BuyFlowState());

  /// Load all available accounts
  Future<void> loadAccounts() async {
    emit(state.copyWith(isLoading: true));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(
        isLoading: false,
        accounts: BuyAccountModel.mockAccounts,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load accounts: ${e.toString()}',
      ));
    }
  }

  /// Load available mediators
  Future<void> loadMediators() async {
    emit(state.copyWith(isLoading: true));

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.copyWith(
        isLoading: false,
        mediators: BuyMediatorModel.mockMediators,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load mediators: ${e.toString()}',
      ));
    }
  }

  /// Select an account
  void selectAccount(BuyAccountModel account) {
    emit(state.copyWith(selectedAccount: account));
  }

  /// Select a mediator
  void selectMediator(BuyMediatorModel mediator) {
    emit(state.copyWith(selectedMediator: mediator));
  }

  /// Clear selections
  void clearSelections() {
    emit(state.copyWith(
      selectedAccount: null,
      selectedMediator: null,
    ));
  }

  /// Submit payment proof
  Future<void> submitPaymentProof({
    required String screenshotUrl,
    required String transactionId,
    required String notes,
  }) async {
    emit(state.copyWith(
      isLoading: true,
      isPaymentSubmitted: true,
    ));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // After submission, show waiting screen
      emit(state.copyWith(
        isLoading: false,
        isWaitingConfirmation: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to submit payment: ${e.toString()}',
      ));
    }
  }

  /// Reset the flow (e.g., after purchase complete)
  void resetFlow() {
    emit(const BuyFlowState());
  }

  /// Clear error message
  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  /// Filter by game
  void filterByGame(String? game) {
    emit(state.copyWith(selectedGame: game));
  }

  /// Filter by price range
  void filterByPriceRange(String? range) {
    emit(state.copyWith(selectedPriceRange: range));
  }

  /// Filter by level/rank
  void filterByLevel(String? level) {
    emit(state.copyWith(selectedLevel: level));
  }

  /// Update search query
  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  /// Update sort option
  void updateSort(String sortBy) {
    emit(state.copyWith(sortBy: sortBy));
  }

  /// Clear all filters
  void clearFilters() {
    emit(state.copyWith(
      clearSelectedGame: true,
      clearSelectedPriceRange: true,
      clearSelectedLevel: true,
      searchQuery: '',
    ));
  }

  /// Get unique games from accounts
  List<String> getAvailableGames() {
    final games = state.accounts.map((a) => a.game).toSet().toList()..sort();
    return games;
  }

  /// Get unique levels/ranks from accounts
  List<String> getAvailableLevels() {
    final levels = state.accounts.map((a) => a.rank).toSet().toList()..sort();
    return levels;
  }
}
