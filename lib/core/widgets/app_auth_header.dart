import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_padding.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive_utils.dart';
import 'app_logo.dart';

/// AppAuthHeader - Reusable authentication screen header
///
/// Features:
/// - Back button (left) + AppLogo (centered)
/// - Title and subtitle
/// - Consistent spacing across all auth screens
///
/// Usage:
/// ```dart
/// AppAuthHeader(
///   title: 'Login',
///   subtitle: 'Welcome back to Trusted',
/// )
/// ```
class AppAuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBackPressed;

  const AppAuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back button and Logo row
        _buildTopRow(context),

        // Title and subtitle section
        _buildTitleSubtitleSection(context),
      ],
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSpacing.m,
        bottom: ResponsiveUtils.scaleSpacing(context, 64),
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: onBackPressed ?? () => context.go('/auth/login'),
            child: const Icon(
              Icons.arrow_back,
              size: 24,
              color: AppColors.textPrimary,
            ),
          ),

          const Spacer(),

          // App Logo (centered)
          const AppLogo(
            size: 32,
            showText: true,
          ),

          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildTitleSubtitleSection(BuildContext context) {
    final fontSize = ResponsiveUtils.scaleFontSize(context, 36);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppPadding.section,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Align(
            child: Text(
              title,
              style: AppTextStyles.heading1.copyWith(
                fontSize: fontSize,
                height: 40 / fontSize,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: ResponsiveUtils.scaleSpacing(context, 12)),

          // Subtitle
          Align(
            child: Text(
              subtitle,
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: ResponsiveUtils.scaleFontSize(context, 18),
                height: 28 / 18,
                color: AppColors.primary.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
