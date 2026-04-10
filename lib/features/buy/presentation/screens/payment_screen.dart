import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/buy_mediator_model.dart';
import '../cubit/payment_cubit.dart';
import '../cubit/payment_state.dart';
import 'payment_success_screen.dart';

/// PaymentScreen - Complete payment screen for mediator deal
///
/// Features:
/// - App bar with back button
/// - Trust/security message
/// - Selected mediator info card
/// - Payment methods display
/// - Warning message
/// - Upload screenshot button
/// - Confirm payment button (enabled only after upload)
class PaymentScreen extends StatelessWidget {
  final BuyMediatorModel mediator;
  final double amount;

  const PaymentScreen({
    super.key,
    required this.mediator,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentCubit(),
      child: _PaymentContent(
        mediator: mediator,
        amount: amount,
      ),
    );
  }
}

class _PaymentContent extends StatefulWidget {
  final BuyMediatorModel mediator;
  final double amount;

  const _PaymentContent({
    required this.mediator,
    required this.amount,
  });

  @override
  State<_PaymentContent> createState() => _PaymentContentState();
}

class _PaymentContentState extends State<_PaymentContent> {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.l),

            // Trust message
            _buildTrustMessage(),

            const SizedBox(height: AppSpacing.l),

            // Mediator info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: Text(
                'Your Mediator',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.s),

            // Mediator card (read-only, not clickable)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: _buildMediatorCard(),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Payment methods section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: _buildPaymentMethodsSection(),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Warning message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: _buildWarningMessage(),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: BlocBuilder<PaymentCubit, PaymentState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      // Upload screenshot button
                      _buildUploadButton(context, state),

                      const SizedBox(height: AppSpacing.m),

                      // Confirm payment button
                      _buildConfirmButton(context, state),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
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
        'Complete Your Payment',
        style: AppTextStyles.heading3,
      ),
    );
  }

  Widget _buildTrustMessage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppRadius.s),
            ),
            child: const Icon(
              Icons.shield_moon_rounded,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Payment',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Your payment is protected until delivery is confirmed',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediatorCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _getTierColor(),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: widget.mediator.avatar.isNotEmpty
                  ? Image.network(
                      widget.mediator.avatar,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultAvatar();
                      },
                    )
                  : _buildDefaultAvatar(),
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
                    Expanded(
                      child: Text(
                        widget.mediator.name,
                        style: AppTextStyles.bodyLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget.mediator.isVerified) ...[
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
                Text(
                  widget.mediator.specialization,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
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
          widget.mediator.name[0].toUpperCase(),
          style: AppTextStyles.heading3.copyWith(
            color: _getTierColor(),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Methods',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: AppSpacing.m),
        ...widget.mediator.paymentMethods.map((method) => _buildPaymentMethodItem(method)),
      ],
    );
  }

  Widget _buildPaymentMethodItem(dynamic method) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.m),
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
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.s),
            ),
            child: Icon(
              _getPaymentIcon(method.icon),
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method.name,
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 2),
                Text(
                  method.details,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getPaymentIcon(String iconName) {
    final iconMap = {
      'account_balance': Icons.account_balance,
      'phone_iphone': Icons.phone_iphone,
      'payment': Icons.payment,
      'wallet': Icons.account_balance_wallet,
    };
    return iconMap[iconName] ?? Icons.payment;
  }

  Widget _buildWarningMessage() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: AppColors.error,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Text(
              'Make sure to upload a clear screenshot of your payment confirmation. The mediator will verify it before proceeding.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.error,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton(BuildContext context, PaymentState state) {
    final hasImage = state.screenshotPath != null;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _pickImage(context),
        style: OutlinedButton.styleFrom(
          foregroundColor: hasImage ? AppColors.success : AppColors.primary,
          side: BorderSide(
            color: hasImage ? AppColors.success : AppColors.primary,
            width: 1.5,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.m,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
          ),
        ),
        icon: Icon(
          hasImage ? Icons.check_circle : Icons.cloud_upload_outlined,
          size: 20,
        ),
        label: Text(
          hasImage ? 'Screenshot Uploaded' : 'Upload Screenshot',
          style: AppTextStyles.buttonText.copyWith(
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context, PaymentState state) {
    final isEnabled = state.screenshotPath != null;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? () => _handleConfirmPayment(context) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? AppColors.primary : AppColors.disabledBackground,
          foregroundColor: AppColors.background,
          disabledBackgroundColor: AppColors.disabledBackground,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.m,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_outline,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.s),
            Text(
              'Confirm Payment',
              style: AppTextStyles.buttonText.copyWith(
                color: isEnabled ? AppColors.background : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null && context.mounted) {
        context.read<PaymentCubit>().uploadScreenshot(image.path);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _handleConfirmPayment(BuildContext context) {
    context.read<PaymentCubit>().confirmPayment();

    // Show success screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentSuccessScreen(
          mediator: widget.mediator,
          amount: widget.amount,
        ),
      ),
    );
  }

  Color _getTierColor() {
    switch (widget.mediator.tier) {
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
