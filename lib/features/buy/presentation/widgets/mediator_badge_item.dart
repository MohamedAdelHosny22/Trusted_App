import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/buy_mediator_model.dart';

/// MediatorBadgeItem - Displays a single achievement badge
///
/// Shows:
/// - Badge icon
/// - Badge name
/// - Badge description
/// - Earned date (optional)
class MediatorBadgeItem extends StatelessWidget {
  final MediatorBadge badge;
  final bool showDescription;

  const MediatorBadgeItem({
    super.key,
    required this.badge,
    this.showDescription = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(
          color: AppColors.borderSubtle,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Badge icon
          _buildBadgeIcon(),

          const SizedBox(width: AppSpacing.m),

          // Badge info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  badge.name,
                  style: AppTextStyles.cardTitle,
                ),
                if (showDescription && badge.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    badge.description,
                    style: AppTextStyles.smallMediumText.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeIcon() {
    Color badgeColor;
    IconData badgeIcon;

    // Determine icon based on badge name or use default
    if (badge.icon.startsWith('http')) {
      // Network image URL
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.s),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.s),
          child: Image.network(
            badge.icon,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildDefaultIcon();
            },
          ),
        ),
      );
    }

    // Use IconData from string name
    badgeColor = _getBadgeColor();
    badgeIcon = _getIconData();

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.s),
      ),
      child: Icon(
        badgeIcon,
        color: badgeColor,
        size: 24,
      ),
    );
  }

  Widget _buildDefaultIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.s),
      ),
      child: const Icon(
        Icons.military_tech,
        color: AppColors.primary,
        size: 24,
      ),
    );
  }

  Color _getBadgeColor() {
    // Map badge names to colors
    final colorMap = {
      'Top Mediator': AppColors.goldTier,
      'Fast Responder': AppColors.eliteTier,
      'Trusted Partner': AppColors.primary,
      'Rising Star': AppColors.warning,
      'Newcomer': AppColors.success,
    };

    return colorMap[badge.name] ?? AppColors.primary;
  }

  IconData _getIconData() {
    // Map badge icon names to IconData
    final iconMap = {
      'emoji_events': Icons.emoji_events,
      'flash_on': Icons.flash_on,
      'verified': Icons.verified,
      'star': Icons.star,
      'new_releases': Icons.new_releases,
      'diamond': Icons.diamond,
      'military_tech': Icons.military_tech,
      'workspace_premium': Icons.workspace_premium,
      'stars': Icons.stars,
    };

    return iconMap[badge.icon] ?? Icons.military_tech;
  }
}
