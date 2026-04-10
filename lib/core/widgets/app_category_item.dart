import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';

/// AppCategoryItem - Circular category item for games
///
/// Features:
/// - Circular container with image
/// - Label below
/// - Optional selection state
class AppCategoryItem extends StatelessWidget {
  final String label;
  final String? imageUrl;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const AppCategoryItem({
    super.key,
    required this.label,
    this.imageUrl,
    this.icon,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circular image container (fixed size)
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: ClipOval(
                child: _buildImageContent(),
              ),
            ),
            const SizedBox(height: 4),
            // Label
            SizedBox(
              width: 80,
              child: Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textPrimary,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContent() {
    if (imageUrl != null) {
      // Check if it's an asset path or network URL
      if (imageUrl!.startsWith('assets/')) {
        return Image.asset(
          imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.image_outlined,
                size: 28,
                color: AppColors.textSecondary,
              ),
            );
          },
        );
      } else {
        return Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                icon ?? Icons.image_outlined,
                size: 28,
                color: AppColors.textSecondary,
              ),
            );
          },
        );
      }
    }

    // No image - show centered icon
    return Center(
      child: Icon(
        icon ?? Icons.image_outlined,
        size: 28,
        color: AppColors.textSecondary,
      ),
    );
  }
}
