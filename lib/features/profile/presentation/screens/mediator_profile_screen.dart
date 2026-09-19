import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/mediator_profile_cubit.dart';
import '../cubit/mediator_profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/stats_grid.dart';
import '../widgets/my_listings_section.dart';
import '../widgets/recent_trade_history_section.dart';
import '../widgets/quick_actions_section.dart';
import '../../data/models/user_stats_model.dart';
import '../../data/models/listing_model.dart';
import '../../data/models/trade_history_model.dart';

/// MediatorProfileScreen - Mediator profile screen
///
/// Displays mediator profile information including:
/// - Profile header with avatar, user info, and mediator badge
/// - Mediator stats card (earnings, tier, rating)
/// - Stats grid (completed deals, sold, bought)
/// - My listings section
/// - Recent trade history
/// - Quick actions
///
/// Reuses existing profile widgets and adds mediator-specific features
class MediatorProfileScreen extends StatelessWidget {
  const MediatorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediatorProfileCubit, MediatorProfileState>(
      builder: (context, state) {
        if (state.isLoading && state.userStats == null) {
          return const _LoadingIndicator();
        }

        if (state.errorMessage != null && state.userStats == null) {
          return _ErrorMessage(message: state.errorMessage!);
        }

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => context.read<MediatorProfileCubit>().refresh(),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: AppSpacing.xl + 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header with mediator badge
                ProfileHeader(
                  username: 'Mediator User',
                  userRole: '${state.mediatorTier ?? 'Gold'} Mediator',
                  memberSince: 'Member since 2023',
                  onEditProfile: () {
                    // TODO: Navigate to edit profile
                  },
                ),

                const SizedBox(height: AppSpacing.m),

                // Mediator Stats Card (Earnings, Tier, Rating)
                if (state.totalEarnings != null || state.mediatorTier != null || state.rating != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                    child: _MediatorStatsCard(
                      totalEarnings: state.totalEarnings ?? 0.0,
                      tier: state.mediatorTier ?? 'Bronze',
                      rating: state.rating ?? 0.0,
                    ),
                  ),

                const SizedBox(height: AppSpacing.l),

                // Stats Grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                  child: StatsGrid(stats: state.userStats ?? UserStatsModel.mock()),
                ),

                const SizedBox(height: AppSpacing.xl),

                // My Listings Section
                MyListingsSection(
                  listings: state.listings ?? ListingModel.mockListings(),
                  onViewAll: () {
                    context.pushNamed('all-listings');
                  },
                  onAddNew: () {
                    context.pushNamed('add-listing');
                  },
                  onListingTap: (listing) {
                    // TODO: Navigate to listing detail
                  },
                ),

                const SizedBox(height: AppSpacing.xl),

                // Recent Trade History
                RecentTradeHistorySection(
                  tradeHistory: state.tradeHistory ?? TradeHistoryModel.mockTradeHistory(),
                  onViewAll: () {
                    // TODO: Navigate to full trade history
                  },
                ),

                const SizedBox(height: AppSpacing.xl),

                // Quick Actions
                const QuickActionsSection(),

                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Mediator Stats Card - Displays mediator-specific stats
///
/// Shows:
/// - Total earnings
/// - Mediator tier (Bronze, Silver, Gold, Platinum)
/// - Overall rating
class _MediatorStatsCard extends StatelessWidget {
  final double totalEarnings;
  final String tier;
  final double rating;

  const _MediatorStatsCard({
    required this.totalEarnings,
    required this.tier,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.15),
            AppColors.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Earnings',
            value: '\$${totalEarnings.toStringAsFixed(2)}',
            valueColor: AppColors.success,
          ),
          _buildVerticalDivider(),
          _buildStatItem(
            icon: Icons.military_tech_outlined,
            label: 'Tier',
            value: tier,
            valueColor: _getTierColor(tier),
          ),
          _buildVerticalDivider(),
          _buildStatItem(
            icon: Icons.star_outlined,
            label: 'Rating',
            value: rating.toStringAsFixed(1),
            valueColor: AppColors.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 24,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.bodyLarge.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withValues(alpha: 0.0),
            AppColors.primary.withValues(alpha: 0.3),
            AppColors.primary.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }

  Color _getTierColor(String tier) {
    switch (tier.toLowerCase()) {
      case 'platinum':
        return const Color(0xFFE5E4E2);
      case 'gold':
        return AppColors.warning;
      case 'silver':
        return const Color(0xFFC0C0C0);
      case 'bronze':
        return const Color(0xFFCD7F32);
      default:
        return AppColors.textSecondary;
    }
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

  const _ErrorMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSpacing.m),
            Text(
              'Error Loading Profile',
              style: AppTextStyles.heading3,
            ),
            const SizedBox(height: AppSpacing.s),
            Text(
              message,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
