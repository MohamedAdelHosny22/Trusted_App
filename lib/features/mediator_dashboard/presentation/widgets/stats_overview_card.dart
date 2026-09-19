import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/mediator_stats_model.dart';

/// StatsOverviewCard - Display mediator statistics
///
/// Shows key metrics: pending, completed, rating, earnings
class StatsOverviewCard extends StatelessWidget {
  final MediatorStatsModel stats;

  const StatsOverviewCard({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats grid (removed "Your Stats" title)
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.pending_actions,
                  label: 'Pending',
                  value: stats.pendingRequests.toString(),
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.check_circle,
                  label: 'Completed',
                  value: stats.completedTransactions.toString(),
                  color: AppColors.success,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.m),

          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.star,
                  label: 'Rating',
                  value: stats.rating.toStringAsFixed(1),
                  color: AppColors.warning,
                  showIcon: false,
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.account_balance_wallet,
                  label: 'Earnings',
                  value: 'EGP ${stats.earnings.toStringAsFixed(0)}',
                  color: AppColors.priceGreen,
                  showIcon: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    bool showIcon = true,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(AppRadius.s),
        border: Border.all(
          color: color.withValues(alpha:0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          if (showIcon) ...[
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(height: AppSpacing.xs),
          ],
          Text(
            value,
            style: AppTextStyles.heading3.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
