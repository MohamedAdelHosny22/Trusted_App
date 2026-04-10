import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_padding.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/app_logo.dart';

/// LoginHeader - Login screen header section
///
/// Features:
/// - App logo with branding
/// - Welcome message
/// - Consistent spacing matching Figma design
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.section,
        bottom: AppPadding.section,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Logo (with text, premium italic style)
          const AppLogo(
            size: 40,
            alignment: MainAxisAlignment.start,
          ),

          SizedBox(height: ResponsiveUtils.scaleSpacing(context, 112)),

          // Login heading
          Align(
            child: Text(
              'Login',
              style: AppTextStyles.heading1.copyWith(
                fontSize: ResponsiveUtils.scaleFontSize(context, 36),
                height: 40 / 36,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: ResponsiveUtils.scaleSpacing(context, 12)),

          // Subtitle
          Align(
            child: Text(
              'Welcome back to Trusted',
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
