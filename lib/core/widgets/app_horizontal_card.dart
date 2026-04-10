import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

/// AppHorizontalCard - Reusable horizontal promo card
///
/// Features:
/// - Background image support
/// - Gradient overlay
/// - Tag support
/// - Title and action button
/// - Rounded corners
class AppHorizontalCard extends StatelessWidget {
  final String tag;
  final String title;
  final String buttonText;
  final VoidCallback? onButtonTap;
  final String? imageUrl;
  final Color? tagColor;
  final Color? overlayColor;

  const AppHorizontalCard({
    super.key,
    required this.tag,
    required this.title,
    required this.buttonText,
    this.onButtonTap,
    this.imageUrl,
    this.tagColor,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: AppSpacing.m),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.l),
        boxShadow: AppShadows.md,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.l),
        child: Stack(
          children: [
            // Background image or color
            Container(
              color: AppColors.surface,
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.surface,
                          child: Icon(
                            Icons.image_outlined,
                            size: 48,
                            color: AppColors.textSecondary,
                          ),
                        );
                      },
                    )
                  : null,
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    overlayColor?.withValues(alpha: 0.3) ??
                        AppColors.background.withValues(alpha: 0.1),
                    overlayColor ?? AppColors.background,
                  ],
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Tag
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: tagColor ?? AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.xs),
                    ),
                    child: Text(
                      tag,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.background,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s),
                  // Title
                  Flexible(
                    child: Text(
                      title,
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.m),
                  // Button
                  SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: onButtonTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.background,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.m,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.s),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: AppTextStyles.buttonText.copyWith(
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
