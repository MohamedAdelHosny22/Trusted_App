import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// SecurityOptionItem - List item for security options
///
/// Displays a security option with icon, title, description, and optional action
class SecurityOptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? description;
  final String? trailingText;
  final VoidCallback? onTap;
  final bool showArrow;

  const SecurityOptionItem({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.trailingText,
    this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.s),
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.cardBorder,
        ),
        child: Row(
          children: [
            // Icon Overlay
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.m),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 24,
              ),
            ),

            const SizedBox(width: AppSpacing.m),

            // Title and Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge,
                  ),
                  if (description != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      description!,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ],
              ),
            ),

            // Trailing
            if (trailingText != null)
              Text(
                trailingText!,
                style: AppTextStyles.bodySmallPrimary,
              )
            else if (showArrow)
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textSecondary,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
