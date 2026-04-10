import '../../data/models/buy_account_model.dart';
import '../../data/models/buy_mediator_model.dart';

/// BuyFlowState - State for the new Buy flow Cubit
///
/// Manages the complete buy flow:
/// 1. Browse accounts with filters
/// 2. Select mediator
/// 3. View account details with mediator info
/// 4. Submit payment proof
/// 5. Wait for confirmation
class BuyFlowState {
  final bool isLoading;
  final String? errorMessage;
  final List<BuyAccountModel> accounts;
  final List<BuyMediatorModel> mediators;
  final BuyAccountModel? selectedAccount;
  final BuyMediatorModel? selectedMediator;
  final bool isPaymentSubmitted;
  final bool isWaitingConfirmation;

  // Filter options
  final String? selectedGame;
  final String? selectedPriceRange;
  final String? selectedLevel;
  final String searchQuery;
  final String sortBy;

  const BuyFlowState({
    this.isLoading = false,
    this.errorMessage,
    this.accounts = const [],
    this.mediators = const [],
    this.selectedAccount,
    this.selectedMediator,
    this.isPaymentSubmitted = false,
    this.isWaitingConfirmation = false,
    this.selectedGame,
    this.selectedPriceRange,
    this.selectedLevel,
    this.searchQuery = '',
    this.sortBy = 'newest',
  });

  BuyFlowState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<BuyAccountModel>? accounts,
    List<BuyMediatorModel>? mediators,
    BuyAccountModel? selectedAccount,
    BuyMediatorModel? selectedMediator,
    bool? isPaymentSubmitted,
    bool? isWaitingConfirmation,
    String? selectedGame,
    String? selectedPriceRange,
    String? selectedLevel,
    String? searchQuery,
    String? sortBy,
    bool clearSelectedGame = false,
    bool clearSelectedPriceRange = false,
    bool clearSelectedLevel = false,
  }) {
    return BuyFlowState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      accounts: accounts ?? this.accounts,
      mediators: mediators ?? this.mediators,
      selectedAccount: selectedAccount ?? this.selectedAccount,
      selectedMediator: selectedMediator ?? this.selectedMediator,
      isPaymentSubmitted: isPaymentSubmitted ?? this.isPaymentSubmitted,
      isWaitingConfirmation: isWaitingConfirmation ?? this.isWaitingConfirmation,
      selectedGame: clearSelectedGame ? null : (selectedGame ?? this.selectedGame),
      selectedPriceRange: clearSelectedPriceRange ? null : (selectedPriceRange ?? this.selectedPriceRange),
      selectedLevel: clearSelectedLevel ? null : (selectedLevel ?? this.selectedLevel),
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuyFlowState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          errorMessage == other.errorMessage &&
          accounts == other.accounts &&
          mediators == other.mediators &&
          selectedAccount == other.selectedAccount &&
          selectedMediator == other.selectedMediator &&
          isPaymentSubmitted == other.isPaymentSubmitted &&
          isWaitingConfirmation == other.isWaitingConfirmation &&
          selectedGame == other.selectedGame &&
          selectedPriceRange == other.selectedPriceRange &&
          selectedLevel == other.selectedLevel &&
          searchQuery == other.searchQuery &&
          sortBy == other.sortBy;

  @override
  int get hashCode =>
      isLoading.hashCode ^
      errorMessage.hashCode ^
      accounts.hashCode ^
      mediators.hashCode ^
      selectedAccount.hashCode ^
      selectedMediator.hashCode ^
      isPaymentSubmitted.hashCode ^
      isWaitingConfirmation.hashCode ^
      selectedGame.hashCode ^
      selectedPriceRange.hashCode ^
      selectedLevel.hashCode ^
      searchQuery.hashCode ^
      sortBy.hashCode;

  /// Get filtered accounts based on current filters
  List<BuyAccountModel> get filteredAccounts {
    var filtered = accounts.toList();

    // Filter by game
    if (selectedGame != null) {
      filtered = filtered.where((account) => account.game == selectedGame).toList();
    }

    // Filter by price range
    if (selectedPriceRange != null) {
      filtered = _filterByPriceRange(filtered, selectedPriceRange!);
    }

    // Filter by level/rank
    if (selectedLevel != null) {
      filtered = filtered.where((account) => account.rank == selectedLevel).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((account) =>
        account.title.toLowerCase().contains(query) ||
        account.game.toLowerCase().contains(query) ||
        account.rank.toLowerCase().contains(query)
      ).toList();
    }

    // Sort
    filtered = _sortAccounts(filtered, sortBy);

    return filtered;
  }

  List<BuyAccountModel> _filterByPriceRange(List<BuyAccountModel> accounts, String range) {
    switch (range) {
      case 'Under \$100':
        return accounts.where((a) => a.price < 100).toList();
      case '\$100 - \$300':
        return accounts.where((a) => a.price >= 100 && a.price <= 300).toList();
      case '\$300 - \$500':
        return accounts.where((a) => a.price >= 300 && a.price <= 500).toList();
      case 'Over \$500':
        return accounts.where((a) => a.price > 500).toList();
      default:
        return accounts;
    }
  }

  List<BuyAccountModel> _sortAccounts(List<BuyAccountModel> accounts, String sortBy) {
    switch (sortBy) {
      case 'newest':
        return accounts.toList(); // TODO: Implement when we have date field
      case 'price_low':
        return accounts..sort((a, b) => a.price.compareTo(b.price));
      case 'price_high':
        return accounts..sort((a, b) => b.price.compareTo(a.price));
      case 'rating':
        return accounts..sort((a, b) => b.rating.compareTo(a.rating));
      default:
        return accounts;
    }
  }

  /// Get account count text
  String get accountCountText => '${filteredAccounts.length} ACCOUNTS FOUND';
}
