import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// AccountCardFavoriteButton - Favorite action button for account cards
///
/// Displays a circular favorite toggle button overlay on card images
class AccountCardFavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onPressed;

  const AccountCardFavoriteButton({
    super.key,
    required this.isFavorite,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.8),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? AppColors.error : AppColors.textPrimary,
          size: AppSpacing.iconSizeSmall,
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 32,
        ),
      ),
    );
  }
}
