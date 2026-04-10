import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// AccountCardBadge - Tier/Featured badge for account cards
///
/// Displays a small badge overlay on account card images
/// Shows tier level (Gold, Elite) or featured status
class AccountCardBadge extends StatelessWidget {
  final String text;
  final Color color;

  const AccountCardBadge({
    super.key,
    required this.text,
    required this.color,
  });

  /// Factory constructor for tier badges
  factory AccountCardBadge.tier(String? tier) {
    final color = _getTierColor(tier);
    final text = _getTierText(tier);
    return AccountCardBadge(
      text: text,
      color: color,
    );
  }

  /// Factory constructor for featured badge
  factory AccountCardBadge.featured() {
    return const AccountCardBadge(
      text: 'FEATURED',
      color: AppColors.accentPurple,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppRadius.chipRadius),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  static Color _getTierColor(String? tier) {
    switch (tier?.toLowerCase()) {
      case 'gold':
        return AppColors.goldTier;
      case 'elite':
        return AppColors.eliteTier;
      default:
        return AppColors.primary;
    }
  }

  static String _getTierText(String? tier) {
    switch (tier?.toLowerCase()) {
      case 'gold':
        return 'GOLD';
      case 'elite':
        return 'ELITE';
      default:
        return tier?.toUpperCase() ?? '';
    }
  }
}
