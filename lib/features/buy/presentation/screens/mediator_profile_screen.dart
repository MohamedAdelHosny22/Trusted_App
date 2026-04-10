import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/buy_mediator_model.dart';
import '../widgets/mediator_profile_header.dart';
import '../widgets/mediator_stats_card.dart';
import '../widgets/mediator_badge_item.dart';
import 'payment_screen.dart';

/// MediatorProfileScreen - Detailed profile view for a mediator
///
/// Features:
/// - Profile header with avatar, name, verification, and tier
/// - Stats row (transactions, user rating, program rating)
/// - Bio section
/// - Badges/achievements section
/// - Responsive layout
class MediatorProfileScreen extends StatelessWidget {
  final BuyMediatorModel mediator;

  const MediatorProfileScreen({
    super.key,
    required this.mediator,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header
            MediatorProfileHeader(mediator: mediator),

            // Stats section
            _buildStatsSection(),

            const SizedBox(height: AppSpacing.l),

            // Bio section
            if (mediator.bio.isNotEmpty) _buildBioSection(),

            const SizedBox(height: AppSpacing.l),

            // Badges section
            if (mediator.badges.isNotEmpty) _buildBadgesSection(),

            const SizedBox(height: AppSpacing.xxl),

            // Start Deal button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: _buildStartDealButton(context),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.textPrimary,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        'Mediator Profile',
        style: AppTextStyles.heading3,
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Row(
        children: [
          MediatorStatsCard.transactions(
            count: mediator.transactionsCount,
          ),
          const SizedBox(width: AppSpacing.m),
          MediatorStatsCard.userRating(
            rating: mediator.rating,
          ),
          const SizedBox(width: AppSpacing.m),
          MediatorStatsCard.programRating(
            rating: mediator.programRating,
          ),
        ],
      ),
    );
  }

  Widget _buildBioSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: AppTextStyles.heading3.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.m),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(AppRadius.cardRadius),
              border: Border.all(
                color: AppColors.borderSubtle,
                width: 1,
              ),
            ),
            child: Text(
              mediator.bio,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Achievements',
            style: AppTextStyles.heading3.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.m,
              crossAxisSpacing: AppSpacing.m,
              childAspectRatio: 1.5,
            ),
            itemCount: mediator.badges.length,
            itemBuilder: (context, index) {
              final badge = mediator.badges[index];
              return MediatorBadgeItem(
                badge: badge,
                showDescription: true,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStartDealButton(BuildContext context) {
    final tierColor = _getTierColor();
    final isPremiumTier = mediator.tier == MediatorTier.elite ||
                         mediator.tier == MediatorTier.gold;

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            tierColor,
            tierColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
        boxShadow: [
          BoxShadow(
            color: tierColor.withValues(alpha: 0.4),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _handleStartDeal(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.background,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flash_on,
              color: AppColors.background,
              size: 24,
            ),
            const SizedBox(width: AppSpacing.s),
            Text(
              'Start Deal With ${mediator.name.split(' ')[0]}',
              style: AppTextStyles.buttonText.copyWith(
                color: AppColors.background,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
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

  void _handleStartDeal(BuildContext context) {
    // Navigate to payment screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          mediator: mediator,
          amount: 100,
        ),
      ),
    );
  }
}
