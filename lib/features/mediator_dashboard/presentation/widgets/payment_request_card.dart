import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/payment_request_model.dart' as models;

/// PaymentRequestCard - Card displaying a payment request
///
/// Shows buyer, seller, account, and payment info
/// Tappable to view full details and screenshot
class PaymentRequestCard extends StatelessWidget {
  final models.PaymentRequestModel request;
  final VoidCallback onTap;

  const PaymentRequestCard({
    super.key,
    required this.request,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.m),
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.cardRadius),
          border: Border.all(
            color: _getStatusColor().withValues(alpha:0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Status + Date
            Row(
              children: [
                _buildStatusBadge(),
                const Spacer(),
                Text(
                  _formatDate(request.createdAt),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.m),

            // Account title
            Text(
              request.accountTitle,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: AppSpacing.s),

            // Amount
            Text(
              'EGP ${request.amount.toStringAsFixed(2)}',
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.priceGreen,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: AppSpacing.m),

            // Buyer and Seller info
            _buildParticipantsRow(),

            const SizedBox(height: AppSpacing.s),

            // Screenshot preview
            _buildScreenshotPreview(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    String label;
    Color color;

    switch (request.status) {
      case models.PaymentRequestStatus.pending:
        label = 'Pending Review';
        color = AppColors.warning;
        break;
      case models.PaymentRequestStatus.approved:
        label = 'Approved';
        color = AppColors.success;
        break;
      case models.PaymentRequestStatus.rejected:
        label = 'Rejected';
        color = AppColors.error;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.15),
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(
          color: color.withValues(alpha:0.5),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildParticipantsRow() {
    return Row(
      children: [
        // Buyer
        Expanded(
          child: _buildParticipantChip(
            label: 'Buyer',
            name: request.buyerName,
            avatar: request.buyerAvatar,
            isBuyer: true,
          ),
        ),

        const SizedBox(width: AppSpacing.s),

        // Arrow
        const Icon(
          Icons.arrow_forward,
          size: 16,
          color: AppColors.textSecondary,
        ),

        const SizedBox(width: AppSpacing.s),

        // Seller
        Expanded(
          child: _buildParticipantChip(
            label: 'Seller',
            name: request.sellerName,
            avatar: request.sellerAvatar,
            isBuyer: false,
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantChip({
    required String label,
    required String name,
    String? avatar,
    required bool isBuyer,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: isBuyer
            ? AppColors.primary.withValues(alpha:0.1)
            : AppColors.accentPurple.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Row(
        children: [
          // Avatar or initials
          if (avatar != null && avatar.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.xs),
              child: Image.network(
                avatar,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildDefaultAvatar(name);
                },
              ),
            )
          else
            _buildDefaultAvatar(name),

          const SizedBox(width: AppSpacing.xs),

          // Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
                Text(
                  name,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(String name) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: AppColors.borderSubtle,
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildScreenshotPreview() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(
          color: AppColors.borderSubtle,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: AppSpacing.s),
          const Icon(
            Icons.image,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Text(
              'Payment Screenshot Uploaded',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.s),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (request.status) {
      case models.PaymentRequestStatus.pending:
        return AppColors.warning;
      case models.PaymentRequestStatus.approved:
        return AppColors.success;
      case models.PaymentRequestStatus.rejected:
        return AppColors.error;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
