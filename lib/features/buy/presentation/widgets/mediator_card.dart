import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/buy_mediator_model.dart';

/// MediatorCard - Displays mediator information in a card format
///
/// Shows:
/// - Avatar with online indicator
/// - Name with verification badge
/// - Tier badge
/// - Star rating
/// - Transaction count
/// - Select Mediator button
/// - Premium visual effects for higher tiers
class MediatorCard extends StatelessWidget {
  final BuyMediatorModel mediator;
  final VoidCallback? onCardTap;
  final VoidCallback onSelectTap;
  final bool isSelected;

  const MediatorCard({
    super.key,
    required this.mediator,
    this.onCardTap,
    required this.onSelectTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.m),
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: _buildCardDecoration(),
        child: Column(
          children: [
            // Main content row
            Row(
              children: [
                // Avatar with online indicator
                _buildAvatar(),

                const SizedBox(width: AppSpacing.m),

                // Mediator info
                Expanded(
                  child: _buildMediatorInfo(),
                ),
              ],
            ),

            // Select Mediator button
            const SizedBox(height: AppSpacing.m),
            _buildSelectButton(),
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
      color: isPremiumTier
          ? tierColor.withValues(alpha: 0.08)
          : AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.cardRadius),
      border: Border.all(
        color: isSelected ? AppColors.primary : _getTierColor().withValues(alpha: 0.3),
        width: isSelected ? 2 : isPremiumTier ? 1.5 : 1,
      ),
      boxShadow: isPremiumTier
          ? [
              BoxShadow(
                color: tierColor.withValues(alpha: 0.15),
                blurRadius: 12,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ]
          : null,
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        // Avatar with tier-specific border
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: _getTierColor(),
              width: _getBorderWidth(),
            ),
            boxShadow: mediator.tier == MediatorTier.elite
                ? [
                    BoxShadow(
                      color: _getTierColor().withValues(alpha: 0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
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

        // Online indicator
        if (mediator.isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.surface,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.success.withValues(alpha: 0.4),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
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
            fontSize: 28,
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

  Widget _buildSelectButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onSelectTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getTierColor().withValues(alpha: 0.15),
          foregroundColor: _getTierColor(),
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.s,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
            side: BorderSide(
              color: _getTierColor().withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
        ),
        child: Text(
          'Select Mediator',
          style: AppTextStyles.buttonText.copyWith(
            color: _getTierColor(),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
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

  String _getTierName() {
    switch (mediator.tier) {
      case MediatorTier.elite:
        return 'ELITE';
      case MediatorTier.gold:
        return 'GOLD';
      case MediatorTier.silver:
        return 'SILVER';
      case MediatorTier.bronze:
        return 'BRONZE';
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
