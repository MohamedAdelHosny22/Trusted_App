import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../buy/data/models/buy_mediator_model.dart';
import 'sell_success_screen.dart';

/// PreviewListingScreen - Preview listing before submission
class PreviewListingScreen extends StatelessWidget {
  final Map<String, dynamic> listingData;

  const PreviewListingScreen({
    super.key,
    required this.listingData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.l),

            // Preview header
            _buildPreviewHeader(),

            const SizedBox(height: AppSpacing.l),

            // Listing preview card
            _buildListingCard(context),

            const SizedBox(height: AppSpacing.xl),

            // Selected mediators
            _buildSelectedMediators(),

            const SizedBox(height: AppSpacing.xxl),

            // Action buttons
            _buildActionButtons(context),

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
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text('Preview Listing', style: AppTextStyles.heading3),
    );
  }

  Widget _buildPreviewHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.preview, color: AppColors.primary, size: 40),
          ),
          const SizedBox(height: AppSpacing.m),
          Text(
            'Review Your Listing',
            style: AppTextStyles.heading2,
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            'Check everything before submitting',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildListingCard(BuildContext context) {
    final images = listingData['images'] as List<String>;
    final mediators = listingData['selectedMediators'] as List<String>;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(color: AppColors.borderSubtle, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Images
          _buildImagesSection(images),

          const SizedBox(height: AppSpacing.m),

          // Game badge
          _buildGameBadge(),

          const SizedBox(height: AppSpacing.m),

          // Price
          _buildPrice(),

          const SizedBox(height: AppSpacing.m),

          // Short description
          _buildShortDescription(),

          const SizedBox(height: AppSpacing.m),

          // Full details
          _buildFullDetails(),

          const SizedBox(height: AppSpacing.m),

          // Mediators count
          _buildMediatorsCount(mediators),
        ],
      ),
    );
  }

  Widget _buildImagesSection(List<String> images) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: index < images.length - 1 ? AppSpacing.m : 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.m),
              child: Image.file(
                File(images[index]),
                width: 150,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGameBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.chipRadius),
      ),
      child: Text(
        listingData['game'] ?? '',
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildPrice() {
    return Text(
      '\$${listingData['price'] ?? '0'}',
      style: AppTextStyles.heading1.copyWith(color: AppColors.priceGreen),
    );
  }

  Widget _buildShortDescription() {
    return Text(
      listingData['shortDescription'] ?? '',
      style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w500),
    );
  }

  Widget _buildFullDetails() {
    return Text(
      listingData['fullDetails'] ?? '',
      style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, height: 1.5),
    );
  }

  Widget _buildMediatorsCount(List<String> mediators) {
    return Row(
      children: [
        const Icon(Icons.people_outline, color: AppColors.textSecondary, size: 16),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '${mediators.length} mediators selected',
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildSelectedMediators() {
    final mediatorIds = listingData['selectedMediators'] as List<String>;
    final selectedMediators = BuyMediatorModel.mockMediators
        .where((m) => mediatorIds.contains(m.id))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Mediators',
            style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.m),
          ...selectedMediators.map((mediator) => _buildMediatorItem(mediator)),
        ],
      ),
    );
  }

  Widget _buildMediatorItem(BuyMediatorModel mediator) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.m),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _getTierColor(mediator), width: 2),
            ),
            child: ClipOval(
              child: mediator.avatar.isNotEmpty
                  ? Image.network(mediator.avatar, fit: BoxFit.cover)
                  : Center(
                      child: Text(
                        mediator.name[0].toUpperCase(),
                        style: AppTextStyles.bodyLarge.copyWith(color: _getTierColor(mediator)),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mediator.name, style: AppTextStyles.body),
                const SizedBox(height: 2),
                Text(
                  mediator.specialization,
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle,
            color: AppColors.success,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Column(
        children: [
          // Edit button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: const BorderSide(color: AppColors.border, width: 1),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.m),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
                ),
              ),
              child: Text('Edit', style: AppTextStyles.buttonText),
            ),
          ),

          const SizedBox(height: AppSpacing.m),

          // Confirm & Submit button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _handleSubmit(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.m),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
                ),
              ),
              child: Text('Confirm & Submit', style: AppTextStyles.buttonText),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const SellSuccessScreen(),
      ),
    );
  }

  Color _getTierColor(BuyMediatorModel mediator) {
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
}
