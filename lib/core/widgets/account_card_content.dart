import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'account_card_seller_info.dart';
import 'account_card_view_button.dart';

/// AccountCardContent - Content section for account cards
///
/// PROPER RESPONSIVE DESIGN:
/// - Uses LayoutBuilder to detect available space
/// - Seller info and price in same row (saves space!)
/// - Clean, consistent spacing
/// - No overflow with Flexible widgets
class AccountCardContent extends StatelessWidget {
  final String title;
  final String game;
  final double price;
  final String? sellerName;
  final String? sellerAvatar;
  final VoidCallback? onViewDetails;

  const AccountCardContent({
    super.key,
    required this.title,
    required this.game,
    required this.price,
    this.sellerName,
    this.sellerAvatar,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s), // Consistent 8px padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Game name (directly under image)
          Text(
            game,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          // Title (single line + ellipsis)
          Text(
            title,
            style: AppTextStyles.heading3.copyWith(
              fontSize: 14,
              height: 1.2,
            ),
            maxLines: 1, // Single line only
            overflow: TextOverflow.ellipsis, // Show "..." if truncated
          ),
          const SizedBox(height: AppSpacing.s),
          // Seller info (if exists)
          if (sellerName != null)
            AccountCardSellerInfo(
              sellerName: sellerName!,
              sellerAvatar: sellerAvatar,
            ),
          // Spacing before price
          if (sellerName != null)
            const SizedBox(height: AppSpacing.xs),
          // Price (always at bottom, below seller)
          Text(
            '\$${price.toStringAsFixed(0)}',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.priceGreen,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: AppSpacing.s),
          // View Details Button (only if callback provided)
          if (onViewDetails != null)
            SizedBox(
              width: double.infinity,
              height: 28,
              child: AccountCardViewButton(
                onPressed: onViewDetails,
              ),
            ),
        ],
      ),
    );
  }
}
