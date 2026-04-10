import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../buy/data/models/buy_mediator_model.dart';

/// MediatorSelectorCard - Card for selecting mediators in sell flow
///
/// Shows:
/// - Avatar with tier badge
/// - Name and verification
/// - Tier badge
/// - Rating and stats
/// - Checkbox for selection
/// - Premium visual effects for higher tiers
class MediatorSelectorCard extends StatelessWidget {
  final BuyMediatorModel mediator;
  final bool isSelected;
  final VoidCallback onTap;

  const MediatorSelectorCard({
    super.key,
    required this.mediator,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: _buildCardDecoration(),
        child: Row(
          children: [
            // Checkbox
            _buildCheckbox(),

            const SizedBox(width: AppSpacing.m),

            // Avatar
            _buildAvatar(),

            const SizedBox(width: AppSpacing.m),

            // Mediator info
            Expanded(
              child: _buildMediatorInfo(),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    final tierColor = _getTierColor();
    final isPremiumTier = mediator.tier == MediatorTier.elite ||
                         mediator.tier == MediatorTier.gold;

    return BoxDecoration(
      color: isSelected
          ? tierColor.withValues(alpha: 0.15)
          : isPremiumTier
              ? tierColor.withValues(alpha: 0.05)
              : AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.cardRadius),
      border: Border.all(
        color: isSelected
            ? tierColor
            : _getTierColor().withValues(alpha: 0.3),
        width: isSelected ? 2 : isPremiumTier ? 1.5 : 1,
      ),
      boxShadow: isSelected && isPremiumTier
          ? [
              BoxShadow(
                color: tierColor.withValues(alpha: 0.2),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ]
          : null,
    );
  }

  Widget _buildCheckbox() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isSelected ? _getTierColor() : AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected
              ? _getTierColor()
              : AppColors.border,
          width: 2,
        ),
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              color: AppColors.background,
              size: 16,
            )
          : null,
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        // Avatar with tier-specific border
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: _getTierColor(),
              width: _getBorderWidth(),
            ),
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

        // Tier badge overlay (for elite and gold)
        if (mediator.tier == MediatorTier.elite || mediator.tier == MediatorTier.gold)
          Positioned(
            left: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: _getTierColor(),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: _getTierColor().withValues(alpha: 0.5),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Text(
                _getTierShortName(),
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.background,
                  fontWeight: FontWeight.w700,
                  fontSize: 8,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getTierColor().withValues(alpha: 0.3),
            _getTierColor().withValues(alpha: 0.1),
          ],
        ),
      ),
      child: Center(
        child: Text(
          mediator.name[0].toUpperCase(),
          style: AppTextStyles.heading3.copyWith(
            color: _getTierColor(),
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildMediatorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name row with verification badge
        Row(
          children: [
            Expanded(
              child: Text(
                mediator.name,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: _isPremiumTier() ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (mediator.isVerified) ...[
              const SizedBox(width: AppSpacing.xs),
              const Icon(
                Icons.verified,
                color: AppColors.primary,
                size: 16,
              ),
            ],
          ],
        ),

        const SizedBox(height: AppSpacing.xs),

        // Rating and transactions row
        Row(
          children: [
            // Stars
            Icon(
              Icons.star,
              color: AppColors.warning,
              size: _isPremiumTier() ? 16 : 14,
            ),
            const SizedBox(width: 4),
            Text(
              mediator.rating.toStringAsFixed(1),
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: _isPremiumTier() ? FontWeight.w600 : FontWeight.w500,
              ),
            ),

            const SizedBox(width: AppSpacing.m),

            // Transactions
            Icon(
              Icons.swap_horiz,
              color: _getTierColor(),
              size: _isPremiumTier() ? 16 : 14,
            ),
            const SizedBox(width: 4),
            Text(
              '${mediator.transactionsCount}',
              style: AppTextStyles.bodySmall.copyWith(
                color: _getTierColor(),
                fontWeight: _isPremiumTier() ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.s),

        // Specialization
        Text(
          mediator.specialization,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  double _getBorderWidth() {
    switch (mediator.tier) {
      case MediatorTier.elite:
        return 3.0;
      case MediatorTier.gold:
        return 2.5;
      case MediatorTier.silver:
        return 2.0;
      case MediatorTier.bronze:
        return 1.5;
    }
  }

  bool _isPremiumTier() {
    return mediator.tier == MediatorTier.elite ||
           mediator.tier == MediatorTier.gold;
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

  String _getTierShortName() {
    switch (mediator.tier) {
      case MediatorTier.elite:
        return 'E';
      case MediatorTier.gold:
        return 'G';
      case MediatorTier.silver:
        return 'S';
      case MediatorTier.bronze:
        return 'B';
    }
  }
}
