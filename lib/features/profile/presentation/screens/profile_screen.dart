import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/stats_grid.dart';
import '../widgets/my_listings_section.dart';
import '../widgets/recent_trade_history_section.dart';
import '../widgets/quick_actions_section.dart';
import '../../data/models/user_stats_model.dart';
import '../../data/models/listing_model.dart';
import '../../data/models/trade_history_model.dart';

/// ProfileScreen - User profile screen
///
/// Displays user profile information including:
/// - Profile header with avatar and user info
/// - Stats grid (completed deals, rating, sold, bought)
/// - My listings section
/// - Recent trade history
/// - Quick actions
///
/// This is a pure content screen - navigation is handled by MainNavShell
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.isLoading && state.userStats == null) {
          return const _LoadingIndicator();
        }

        if (state.errorMessage != null && state.userStats == null) {
          return _ErrorMessage(message: state.errorMessage!);
        }

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => context.read<ProfileCubit>().refresh(),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: AppSpacing.xl + 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header with gradient background
                ProfileHeader(
                  username: 'CyberHunter',
                  userRole: 'Pro Trader',
                  memberSince: 'Member since 2021',
                  onEditProfile: () {
                    // TODO: Navigate to edit profile
                  },
                ),

                const SizedBox(height: 8),

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
                    // TODO: Navigate to listing details
                  },
                ),

                const SizedBox(height: AppSpacing.xl),

                // Recent Trade History Section
                RecentTradeHistorySection(
                  tradeHistory: state.tradeHistory ?? TradeHistoryModel.mockTradeHistory(),
                  onViewAll: () {
                    // TODO: Navigate to all trade history
                  },
                ),

                const SizedBox(height: AppSpacing.xl),

                // Quick Actions Section
                const QuickActionsSection(),

                SizedBox(height: AppSpacing.xl + 80),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final String message;

  const _ErrorMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.m),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: AppColors.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading profile',
                style: AppTextStyles.heading2.copyWith(
                  color: const Color(0xFFF1F5F9),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: AppTextStyles.body.copyWith(
                  color: const Color(0xFF94A3B8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.read<ProfileCubit>().refresh(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: const Color(0xFF0F2223),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
