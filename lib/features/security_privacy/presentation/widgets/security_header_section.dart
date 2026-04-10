import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// SecurityHeaderSection - Header with back button and title
///
/// Displays the screen title with navigation back button
class SecurityHeaderSection extends StatelessWidget {
  final String title;
  final VoidCallback? onBackTap;

  const SecurityHeaderSection({
    super.key,
    required this.title,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.m,
      ),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: onBackTap ?? () => context.pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.s),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.textPrimary,
                size: AppSpacing.iconSizeSmall,
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.m),

          // Title
          Text(
            title,
            style: AppTextStyles.heading1,
          ),
        ],
      ),
    );
  }
}
