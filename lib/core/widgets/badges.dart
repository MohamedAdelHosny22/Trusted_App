import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_radius.dart';
import '../theme/app_text_styles.dart';

/// StatusBadge - Pill-shaped status indicator
///
/// Supported statuses:
/// - completed: Green text + 10% green background
/// - pending: Yellow text + 10% yellow background
/// - cancelled: Red text + 10% red background
/// - active: Cyan text + 10% cyan background
/// - sold: Purple text + 10% purple background
class StatusBadge extends StatelessWidget {
  final String status;
  final bool isUppercase;
  final double? fontSize;

  const StatusBadge({
    super.key,
    required this.status,
    this.isUppercase = true,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final statusData = _getStatusData(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: statusData.backgroundColor,
        borderRadius: AppRadius.badgeBorder,
      ),
      child: Text(
        isUppercase ? status.toUpperCase() : status,
        style: AppTextStyles.caption.copyWith(
          color: statusData.textColor,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
        ),
      ),
    );
  }

  _StatusData _getStatusData(String status) {
    final normalizedStatus = status.toLowerCase();

    switch (normalizedStatus) {
      case 'completed':
      case 'done':
      case 'success':
        return _StatusData(
          textColor: AppColors.success,
          backgroundColor: AppColors.successBackground,
        );
      case 'pending':
      case 'in_progress':
      case 'waiting':
        return _StatusData(
          textColor: AppColors.warning,
          backgroundColor: AppColors.warningBackground,
        );
      case 'cancelled':
      case 'failed':
      case 'error':
        return _StatusData(
          textColor: AppColors.error,
          backgroundColor: AppColors.errorBackground,
        );
      case 'active':
      case 'ongoing':
        return _StatusData(
          textColor: AppColors.primary,
          backgroundColor: AppColors.primary.withValues(alpha:0.1),
        );
      case 'sold':
        return _StatusData(
          textColor: const Color(0xFF9D4EDD),
          backgroundColor: const Color(0xFF9D4EDD).withValues(alpha:0.1),
        );
      default:
        return _StatusData(
          textColor: AppColors.textSecondary,
          backgroundColor: AppColors.border.withValues(alpha:0.5),
        );
    }
  }
}

class _StatusData {
  final Color textColor;
  final Color backgroundColor;

  _StatusData({
    required this.textColor,
    required this.backgroundColor,
  });
}

/// TierBadge - Special badge for mediator tiers
///
/// Features:
/// - Gold/Elite/Standard styling
/// - Glowing effect for premium tiers
/// - Custom size support
class TierBadge extends StatelessWidget {
  final String tier;
  final bool showGlow;

  const TierBadge({
    super.key,
    required this.tier,
    this.showGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    final tierData = _getTierData(tier);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: tierData.backgroundColor,
        borderRadius: AppRadius.badgeBorder,
        border: Border.all(
          color: tierData.borderColor,
          width: 1,
        ),
        boxShadow: showGlow ? tierData.shadows : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (tierData.icon != null) ...[
            Icon(
              tierData.icon,
              size: 14,
              color: tierData.textColor,
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            tierData.label,
            style: AppTextStyles.caption.copyWith(
              color: tierData.textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  _TierData _getTierData(String tier) {
    switch (tier.toLowerCase()) {
      case 'gold':
        return _TierData(
          label: 'GOLD',
          textColor: AppColors.goldTier,
          backgroundColor: AppColors.goldTier.withValues(alpha:0.15),
          borderColor: AppColors.goldTier,
          icon: Icons.workspace_premium,
          shadows: [
            BoxShadow(
              color: AppColors.goldTier.withValues(alpha:0.3),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        );
      case 'elite':
        return _TierData(
          label: 'ELITE',
          textColor: AppColors.eliteTier,
          backgroundColor: AppColors.eliteTier.withValues(alpha:0.15),
          borderColor: AppColors.eliteTier,
          icon: Icons.verified,
          shadows: [
            BoxShadow(
              color: AppColors.eliteTier.withValues(alpha:0.3),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        );
      default:
        return _TierData(
          label: 'STANDARD',
          textColor: AppColors.textSecondary,
          backgroundColor: AppColors.border.withValues(alpha:0.5),
          borderColor: AppColors.border,
          icon: Icons.person,
          shadows: [],
        );
    }
  }
}

class _TierData {
  final String label;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final IconData? icon;
  final List<BoxShadow> shadows;

  _TierData({
    required this.label,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    this.icon,
    required this.shadows,
  });
}

/// NotificationBadge - Badge for notification count
///
/// Features:
/// - Circle shape
/// - Auto-sizing based on count
/// - Hide when count is 0
class NotificationBadge extends StatelessWidget {
  final int count;
  final double size;

  const NotificationBadge({
    super.key,
    required this.count,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    if (count == 0) return const SizedBox.shrink();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.error,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          count > 99 ? '99+' : count.toString(),
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: count > 99 ? 8 : null,
          ),
        ),
      ),
    );
  }
}

/// CategoryBadge - Badge for game categories
///
/// Features:
/// - Custom colors for different games
/// - Pill shape
/// - Label text
class CategoryBadge extends StatelessWidget {
  final String category;
  final Color? color;

  const CategoryBadge({
    super.key,
    required this.category,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final badgeColor = color ?? _getCategoryColor(category);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha:0.1),
        borderRadius: AppRadius.badgeBorder,
        border: Border.all(
          color: badgeColor.withValues(alpha:0.3),
          width: 1,
        ),
      ),
      child: Text(
        category,
        style: AppTextStyles.caption.copyWith(
          color: badgeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    final normalizedCategory = category.toLowerCase();

    switch (normalizedCategory) {
      case 'pubg':
      case 'pubg mobile':
        return const Color(0xFFFF9F43);
      case 'free fire':
        return const Color(0xFFFF6B6B);
      case 'call of duty':
      case 'cod':
        return const Color(0xFF54A0FF);
      case 'fortnite':
        return const Color(0xFF5F27CD);
      case 'valorant':
        return const Color(0xFFFF9FF3);
      case 'league of legends':
      case 'lol':
        return const Color(0xFF00D2D3);
      default:
        return AppColors.primary;
    }
  }
}
