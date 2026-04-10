import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// AccountCardSellerInfo - Seller information section for account cards
///
/// Displays the seller's avatar and username below the account image
class AccountCardSellerInfo extends StatelessWidget {
  final String sellerName;
  final String? sellerAvatar;

  const AccountCardSellerInfo({
    super.key,
    required this.sellerName,
    this.sellerAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
      child: Row(
        children: [
          // Seller Avatar
          CircleAvatar(
            radius: 12,
            backgroundColor: AppColors.surface,
            backgroundImage: sellerAvatar != null && sellerAvatar!.isNotEmpty
                ? CachedNetworkImageProvider(sellerAvatar!)
                : null,
            child: (sellerAvatar == null || sellerAvatar!.isEmpty)
                ? ClipOval(
                    child: Image.asset(
                      'assets/images/377aab6c8d17efa8c86ca94cf4e6cc0d.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          size: 14,
                          color: AppColors.textSecondary,
                        );
                      },
                    ),
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.xs),
          // Seller Name
          Expanded(
            child: Text(
              sellerName,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
