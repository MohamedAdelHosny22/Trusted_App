import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_logo.dart';
import '../widgets/buy_account_card.dart';
import '../../data/models/buy_account_model.dart';
import '../../data/models/buy_mediator_model.dart';
import '../cubit/buy_flow_cubit.dart';
import '../cubit/buy_flow_state.dart';
import 'account_details_screen.dart';

/// BuyAccountsScreen - Main buy screen with accounts listing
///
/// Features:
/// - Search by text (game name, account title, rank)
/// - Filter tabs (Game | Price Range | Level)
/// - Sort options (Newest, Price, Rating)
/// - Grid of game accounts available for purchase
class BuyAccountsScreen extends StatelessWidget {
  const BuyAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BuyFlowCubit()..loadAccounts(),
      child: const _AccountsContent(),
    );
  }
}

class _AccountsContent extends StatefulWidget {
  const _AccountsContent();

  @override
  State<_AccountsContent> createState() => _AccountsContentState();
}

class _AccountsContentState extends State<_AccountsContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header - Logo left, Notification right (like home)
            _buildHeader(),

            const SizedBox(height: AppSpacing.m),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: _buildSearchBar(),
            ),

            const SizedBox(height: AppSpacing.m),

            // Filter tabs
            const _FilterTabsSection(),

            const SizedBox(height: AppSpacing.m),

            // Accounts grid
            const Expanded(child: _AccountsGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.m,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo on left (like home)
          const AppLogo(
            size: 40,
            alignment: MainAxisAlignment.start,
          ),

          // Notification icon
          _buildNotificationButton(),
        ],
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: const Icon(
        Icons.notifications_outlined,
        color: AppColors.textPrimary,
        size: 22,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: TextField(
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
        decoration: const InputDecoration(
          hintText: 'Search accounts, games, price...',
          hintStyle: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search_outlined,
            color: AppColors.textSecondary,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12),
        ),
        onChanged: (query) {
          context.read<BuyFlowCubit>().updateSearchQuery(query);
        },
      ),
    );
  }
}

class _FilterTabsSection extends StatelessWidget {
  const _FilterTabsSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuyFlowCubit, BuyFlowState>(
      buildWhen: (previous, current) =>
          previous.selectedGame != current.selectedGame ||
          previous.selectedPriceRange != current.selectedPriceRange ||
          previous.selectedLevel != current.selectedLevel,
      builder: (context, state) {
        String selectedTab = 'Game';
        if (state.selectedPriceRange != null) {
          selectedTab = 'Price Range';
        } else if (state.selectedLevel != null) {
          selectedTab = 'Level';
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
          child: Row(
            children: [
              _buildTab(context, 'Game', selectedTab, state),
              const SizedBox(width: 8),
              _buildTab(context, 'Price Range', selectedTab, state),
              const SizedBox(width: 8),
              _buildTab(context, 'Level', selectedTab, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(BuildContext context, String label, String selectedTab, BuyFlowState state) {
    final isSelected = selectedTab == label;

    return GestureDetector(
      onTap: () => _handleTabSelection(context, label, state),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.background : AppColors.textSecondary,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _handleTabSelection(BuildContext context, String tab, BuyFlowState state) {
    final cubit = context.read<BuyFlowCubit>();

    switch (tab) {
      case 'Game':
        _showGameFilterSheet(context, cubit);
        break;
      case 'Price Range':
        _showPriceRangeFilterSheet(context, cubit);
        break;
      case 'Level':
        _showLevelFilterSheet(context, cubit);
        break;
    }
  }

  void _showGameFilterSheet(BuildContext context, BuyFlowCubit cubit) {
    final games = cubit.getAvailableGames();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _FilterSheet(
        title: 'Select Game',
        options: ['All Games', ...games],
        selectedOption: cubit.state.selectedGame ?? 'All Games',
        onOptionSelected: (game) {
          cubit.filterByGame(game == 'All Games' ? null : game);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showPriceRangeFilterSheet(BuildContext context, BuyFlowCubit cubit) {
    const priceRanges = [
      'All Prices',
      'Under \$100',
      '\$100 - \$300',
      '\$300 - \$500',
      'Over \$500',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _FilterSheet(
        title: 'Select Price Range',
        options: priceRanges,
        selectedOption: cubit.state.selectedPriceRange ?? 'All Prices',
        onOptionSelected: (range) {
          cubit.filterByPriceRange(range == 'All Prices' ? null : range);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showLevelFilterSheet(BuildContext context, BuyFlowCubit cubit) {
    final levels = cubit.getAvailableLevels();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _FilterSheet(
        title: 'Select Level',
        options: ['All Levels', ...levels],
        selectedOption: cubit.state.selectedLevel ?? 'All Levels',
        onOptionSelected: (level) {
          cubit.filterByLevel(level == 'All Levels' ? null : level);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _FilterSheet extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onOptionSelected;

  const _FilterSheet({
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textBright,
            ),
          ),
          const SizedBox(height: 16),
          ...options.map((option) => _buildOption(option)),
        ],
      ),
    );
  }

  Widget _buildOption(String option) {
    final isSelected = option == selectedOption;

    return ListTile(
      title: Text(
        option,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing: isSelected
          ? const Icon(
              Icons.check_circle,
              color: AppColors.primary,
              size: 20,
            )
          : null,
      onTap: () => onOptionSelected(option),
    );
  }
}

class _AccountsGrid extends StatelessWidget {
  const _AccountsGrid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuyFlowCubit, BuyFlowState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const _LoadingIndicator();
        }

        if (state.errorMessage != null) {
          return _ErrorMessage(
            message: state.errorMessage!,
            onRetry: () => context.read<BuyFlowCubit>().loadAccounts(),
          );
        }

        final accounts = state.filteredAccounts;

        if (accounts.isEmpty) {
          return const _EmptyState();
        }

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => context.read<BuyFlowCubit>().loadAccounts(),
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts[index];
              return BuyAccountCard(
                account: account,
                onTap: () => _navigateToDetails(context, account),
                onViewDetails: () => _navigateToDetails(context, account),
              );
            },
          ),
        );
      },
    );
  }

  void _navigateToDetails(BuildContext context, BuyAccountModel account) {
    // Create default mediator immediately
    final mediator = BuyMediatorModel(
      id: 'default',
      name: account.seller,
      avatar: account.sellerAvatar,
      rating: account.rating,
      programRating: account.rating,
      transactionsCount: account.reviewsCount,
      specialization: account.game,
      paymentMethods: const [],
      responseTime: 'Available now',
      isOnline: true,
      tier: MediatorTier.bronze,
      isVerified: false,
      badges: const [],
      bio: 'Professional mediator for ${account.game}',
    );

    // Navigate directly to account details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AccountDetailsScreen(
          account: account,
          mediator: mediator,
        ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorMessage({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            const Text(
              'Error loading accounts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textBright,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 48,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          const Text(
            'No accounts found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textBright,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try adjusting your filters',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
