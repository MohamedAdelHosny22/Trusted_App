import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/models/user_stats_model.dart';
import 'stats_item_card.dart';

class _StarIcon extends StatelessWidget {
  const _StarIcon();

  @override
  Widget build(BuildContext context) {
    // Figma: 16.67px × 15.83px, color #00EEFF (Cyan)
    return Icon(
      Icons.star,
      size: 16.67,
      color: AppColors.primary,
    );
  }
}

/// StatsGrid - Grid of user statistics cards
///
/// Displays 4 stat cards in a 2x2 grid layout
/// Figma Design: Node 2312:3
/// - 2 columns, 2 rows
/// - Gap: 16px (AppSpacing.m)
/// - Cards have consistent spacing and styling
class StatsGrid extends StatelessWidget {
  final UserStatsModel? stats;

  const StatsGrid({
    super.key,
    this.stats,
  });

  @override
  Widget build(BuildContext context) {
    // Fallback stats if none provided
    final displayStats = stats ?? UserStatsModel.mock();

    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.m,
        crossAxisSpacing: AppSpacing.m,
        childAspectRatio: 1.8, // Figma: Card aspect ratio
      ),
      children: [
        StatsItemCard(
          label: 'Completed',
          value: '${displayStats.completedDeals}',
          subtitle: 'Deals',
        ),
        StatsItemCard(
          label: 'Rating',
          value: '${displayStats.rating}',
          icon: const _StarIcon(),
        ),
        StatsItemCard(
          label: 'Accounts Sold',
          value: '${displayStats.accountsSold}',
        ),
        StatsItemCard(
          label: 'Bought',
          value: '${displayStats.boughtCount}',
        ),
      ],
    );
  }
}
