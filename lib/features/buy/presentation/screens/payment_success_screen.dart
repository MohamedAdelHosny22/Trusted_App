import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/buy_mediator_model.dart';

/// PaymentSuccessScreen - Success screen after payment confirmation
///
/// Features:
/// - Success animation/icon
/// - Confirmation message
/// - Mediator info
/// - Next steps
/// - Back to home button
class PaymentSuccessScreen extends StatelessWidget {
  final BuyMediatorModel mediator;
  final double amount;

  const PaymentSuccessScreen({
    super.key,
    required this.mediator,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.m),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success icon
              _buildSuccessIcon(),

              const SizedBox(height: AppSpacing.xl),

              // Success message
              _buildSuccessMessage(),

              const SizedBox(height: AppSpacing.xl),

              // Info card
              _buildInfoCard(),

              const SizedBox(height: AppSpacing.xl),

              // Next steps
              _buildNextSteps(),

              const SizedBox(height: AppSpacing.xxl),

              // Back to home button
              _buildBackToHomeButton(context),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: const SizedBox(), // No back button
      centerTitle: true,
      title: Text(
        'Payment Successful',
        style: AppTextStyles.heading3,
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check_circle_outline,
        color: AppColors.success,
        size: 60,
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Column(
      children: [
        Text(
          'Payment Submitted!',
          style: AppTextStyles.heading2.copyWith(
            color: AppColors.success,
          ),
        ),
        const SizedBox(height: AppSpacing.m),
        Text(
          'Your payment has been submitted successfully.\n${mediator.name} will verify your payment and\nrespond to your request shortly.',
          style: AppTextStyles.body.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(
          color: AppColors.borderSubtle,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Mediator row
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _getTierColor(),
                    width: 2,
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
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mediator.name,
                      style: AppTextStyles.bodyLarge,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      mediator.specialization,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.m),
          const Divider(color: AppColors.borderSubtle),
          const SizedBox(height: AppSpacing.m),

          // Amount row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.priceGreen,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: AppColors.cardSurface,
      child: Center(
        child: Text(
          mediator.name[0].toUpperCase(),
          style: AppTextStyles.heading3.copyWith(
            color: _getTierColor(),
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildNextSteps() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.s),
              Text(
                'What happens next?',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.m),
          _buildStep(
            '1',
            '${mediator.name} will review your payment',
          ),
          const SizedBox(height: AppSpacing.s),
          _buildStep(
            '2',
            'You\'ll receive a confirmation once verified',
          ),
          const SizedBox(height: AppSpacing.s),
          _buildStep(
            '3',
            'Your account delivery will begin shortly',
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.background,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.s),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackToHomeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _handleBackToHome(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.m,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
          ),
          side: const BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Text(
          'Back to Home',
          style: AppTextStyles.buttonText.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  void _handleBackToHome(BuildContext context) {
    // Navigate back to home/main screen
    Navigator.of(context).popUntil((route) => route.isFirst);
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
}
