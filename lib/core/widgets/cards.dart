import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_text_styles.dart';
import 'buttons.dart';
import 'badges.dart';

/// AccountCard - Card for displaying game account listings
///
/// Features:
/// - Image thumbnail with loading state
/// - Title, price, and metadata
/// - Status badge support
/// - Optional action button
class AccountCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String? subtitle;
  final String? category;
  final String? status;
  final VoidCallback? onTap;
  final VoidCallback? onAction;
  final String? actionButtonText;
  final bool showAction;

  const AccountCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.subtitle,
    this.category,
    this.status,
    this.onTap,
    this.onAction,
    this.actionButtonText,
    this.showAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.cardBorder,
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.l),
                topRight: Radius.circular(AppRadius.l),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 150,
                  color: AppColors.border,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 150,
                  color: AppColors.border,
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 48,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category and Status Row
                  if (category != null || status != null)
                    Row(
                      children: [
                        if (category != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.s,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha:0.1),
                              borderRadius: AppRadius.chipBorder,
                            ),
                            child: Text(
                              category!,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        if (category != null && status != null)
                          const SizedBox(width: AppSpacing.s),
                        if (status != null)
                          StatusBadge(
                            status: status!,
                          ),
                      ],
                    ),
                  if (category != null || status != null)
                    const SizedBox(height: AppSpacing.s),

                  // Title
                  Text(
                    title,
                    style: AppTextStyles.heading3,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      subtitle!,
                      style: AppTextStyles.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  const SizedBox(height: AppSpacing.m),

                  // Price and Action Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: AppTextStyles.heading2Primary,
                      ),
                      if (showAction && onAction != null)
                        ActionIconButton(
                          icon: Icons.arrow_forward,
                          onPressed: onAction,
                          iconColor: AppColors.primary,
                          showBackground: true,
                          backgroundColor: AppColors.primary.withValues(alpha:0.1),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// MediatorCard - Premium card for mediators
///
/// Features:
/// - Tier-based styling (Gold, Elite, Standard)
/// - Profile avatar and name
/// - Stats (success rate, active deals)
/// - Rating display
class MediatorCard extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final String tier; // 'gold', 'elite', 'standard'
  final double rating;
  final int completedDeals;
  final int activeDeals;
  final VoidCallback? onTap;

  const MediatorCard({
    super.key,
    required this.name,
    this.avatarUrl,
    required this.tier,
    required this.rating,
    required this.completedDeals,
    required this.activeDeals,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tierData = _getTierData(tier);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.cardBorder,
          border: Border.all(
            color: tierData.borderColor,
            width: tierData.borderWidth,
          ),
          boxShadow: tierData.shadows,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: tierData.borderColor,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: avatarUrl != null
                      ? CachedNetworkImage(
                    imageUrl: avatarUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.border,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.border,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )
                      : Container(
                    color: AppColors.border,
                    child: const Icon(
                      Icons.person,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: AppSpacing.m),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: AppTextStyles.heading3,
                        ),
                        const SizedBox(width: AppSpacing.s),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: tierData.backgroundColor,
                            borderRadius: AppRadius.chipBorder,
                          ),
                          child: Text(
                            tierData.label,
                            style: AppTextStyles.caption.copyWith(
                              color: tierData.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.warning,
                          size: 16,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          rating.toStringAsFixed(1),
                          style: AppTextStyles.bodySmall,
                        ),
                        const SizedBox(width: AppSpacing.s),
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 16,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          '$completedDeals deals',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '$activeDeals active',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _TierData _getTierData(String tier) {
    switch (tier.toLowerCase()) {
      case 'gold':
        return _TierData(
          borderColor: AppColors.goldTier,
          borderWidth: 1.5,
          shadows: AppShadows.mediatorCardGold,
          backgroundColor: AppColors.goldTier.withValues(alpha:0.1),
          textColor: AppColors.goldTier,
          label: 'Gold',
        );
      case 'elite':
        return _TierData(
          borderColor: AppColors.eliteTier,
          borderWidth: 1.5,
          shadows: AppShadows.mediatorCardElite,
          backgroundColor: AppColors.eliteTier.withValues(alpha:0.1),
          textColor: AppColors.eliteTier,
          label: 'Elite',
        );
      default:
        return _TierData(
          borderColor: AppColors.border,
          borderWidth: 1,
          shadows: AppShadows.card,
          backgroundColor: AppColors.border.withValues(alpha:0.3),
          textColor: AppColors.textSecondary,
          label: 'Standard',
        );
    }
  }
}

class _TierData {
  final Color borderColor;
  final double borderWidth;
  final List<BoxShadow> shadows;
  final Color backgroundColor;
  final Color textColor;
  final String label;

  _TierData({
    required this.borderColor,
    required this.borderWidth,
    required this.shadows,
    required this.backgroundColor,
    required this.textColor,
    required this.label,
  });
}

/// InfoCard - Simple info card with title and content
///
/// Use for displaying information, stats, or simple content
class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData? icon;
  final Color? iconColor;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardBorder,
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: iconColor ?? AppColors.primary,
              size: AppSpacing.iconSizeLarge,
            ),
            const SizedBox(width: AppSpacing.m),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  content,
                  style: AppTextStyles.heading3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
