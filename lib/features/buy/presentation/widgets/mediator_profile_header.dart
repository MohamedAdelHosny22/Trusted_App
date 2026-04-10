import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/buy_mediator_model.dart';

/// MediatorProfileHeader - Profile header section with avatar and tier badge
///
/// Shows:
/// - Large avatar with verification badge overlay
/// - Tier badge below avatar
/// - Responsive sizing
class MediatorProfileHeader extends StatelessWidget {
  final BuyMediatorModel mediator;

  const MediatorProfileHeader({
    super.key,
    required this.mediator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.l),

        // Avatar with verification badge
        _buildAvatar(),

        const SizedBox(height: AppSpacing.m),

        // Name with verification
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mediator.name,
              style: AppTextStyles.heading2,
            ),
            if (mediator.isVerified) ...[
              const SizedBox(width: AppSpacing.xs),
              const Icon(
                Icons.verified,
                color: AppColors.primary,
                size: 24,
              ),
            ],
          ],
        ),

        const SizedBox(height: AppSpacing.s),

        // Tier badge
        _buildTierBadge(),

        const SizedBox(height: AppSpacing.l),
      ],
    );
  }

  Widget _buildAvatar() {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _getTierColor(),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: _getTierColor().withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipOval(
          child: mediator.avatar.isNotEmpty
              ? Image.network(
                  mediator.avatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildDefaultAvatar();
                  },
                )
              : _buildDefaultAvatar(),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: AppColors.cardSurface,
      child: Center(
        child: Text(
          mediator.name[0].toUpperCase(),
          style: AppTextStyles.heading1.copyWith(
            color: _getTierColor(),
            fontSize: 48,
          ),
        ),
      ),
    );
  }

  Widget _buildTierBadge() {
    final tierColor = _getTierColor();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.s,
      ),
      decoration: BoxDecoration(
        color: tierColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.badgeRadius),
        border: Border.all(
          color: tierColor.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getTierIcon(),
            color: tierColor,
            size: 16,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            _getTierName(),
            style: AppTextStyles.bodySmall.copyWith(
              color: tierColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Color _getTierColor() {
    switch (mediator.tier) {
      case MediatorTier.elite:
        return AppColors.eliteTier;
      case MediatorTier.gold:
        return AppColors.goldTier;
      case MediatorTier.silver:
        return const Color(0xFFC0C0C0);
      case MediatorTier.bronze:
        return const Color(0xFFCD7F32);
    }
  }

  String _getTierName() {
    switch (mediator.tier) {
      case MediatorTier.elite:
        return 'ELITE MEDIATOR';
      case MediatorTier.gold:
        return 'GOLD MEDIATOR';
      case MediatorTier.silver:
        return 'SILVER MEDIATOR';
      case MediatorTier.bronze:
        return 'BRONZE MEDIATOR';
    }
  }

  IconData _getTierIcon() {
    switch (mediator.tier) {
      case MediatorTier.elite:
        return Icons.diamond;
      case MediatorTier.gold:
        return Icons.military_tech;
      case MediatorTier.silver:
        return Icons.stars;
      case MediatorTier.bronze:
        return Icons.workspace_premium;
    }
  }
}
