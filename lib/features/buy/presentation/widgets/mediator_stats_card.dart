import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// MediatorStatsCard - Displays a single stat with icon and label
///
/// Used for:
/// - Successful mediations count
/// - User rating
/// - Program rating
class MediatorStatsCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color? iconColor;

  const MediatorStatsCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.iconColor,
  });

  /// Factory constructor for transactions count
  factory MediatorStatsCard.transactions({
    required int count,
    Key? key,
  }) {
    return MediatorStatsCard(
      key: key,
      value: count.toString(),
      label: 'Successful\nMediations',
      icon: Icons.swap_horiz_rounded,
      iconColor: AppColors.success,
    );
  }

  /// Factory constructor for user rating
  factory MediatorStatsCard.userRating({
    required double rating,
    Key? key,
  }) {
    return MediatorStatsCard(
      key: key,
      value: rating.toStringAsFixed(1),
      label: 'User\nRating',
      icon: Icons.star_rounded,
      iconColor: AppColors.warning,
    );
  }

  /// Factory constructor for program rating
  factory MediatorStatsCard.programRating({
    required double rating,
    Key? key,
  }) {
    return MediatorStatsCard(
      key: key,
      value: rating.toStringAsFixed(1),
      label: 'Program\nRating',
      icon: Icons.verified_rounded,
      iconColor: AppColors.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.cardRadius),
          border: Border.all(
            color: AppColors.borderSubtle,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.primary).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppRadius.s),
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.primary,
                size: 20,
              ),
            ),

            const SizedBox(height: AppSpacing.m),

            // Value
            Text(
              value,
              style: AppTextStyles.statsNumber.copyWith(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 4),

            // Label
            Text(
              label,
              style: AppTextStyles.smallMediumText.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
