import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

/// AppBanner - Reusable info/promo banner component
///
/// Features:
/// - Rounded container with subtle background
/// - Icon support
/// - Customizable text
/// - Border with shadow
class AppBanner extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  const AppBanner({
    super.key,
    required this.text,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.onTap,
  });

  /// Factory for secure trading banner
  factory AppBanner.secure({VoidCallback? onTap}) {
    return AppBanner(
      text: '🔒 Secure trading with verified mediators',
      backgroundColor: AppColors.surface,
      textColor: AppColors.textPrimary,
      borderColor: AppColors.border,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
          vertical: AppSpacing.s,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: AppSpacing.s,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.m),
          border: Border.all(
            color: borderColor ?? AppColors.border,
            width: 1,
          ),
          boxShadow: AppShadows.xs,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: textColor ?? AppColors.textPrimary,
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            Flexible(
              child: Text(
                text,
                style: AppTextStyles.bodySmall.copyWith(
                  color: textColor ?? AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
