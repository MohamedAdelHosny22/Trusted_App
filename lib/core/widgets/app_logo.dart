import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// AppLogo - Reusable app branding widget
///
/// Features:
/// - Logo image with configurable size
/// - "Trusted" text label
/// - Optional premium/italic style for text
/// - Fully customizable (size, showText, alignment)
///
/// Usage:
/// ```dart
/// // Default (with text, centered)
/// AppLogo()
///
/// // Icon only
/// AppLogo(showText: false)
///
/// // Custom size
/// AppLogo(size: 64)
///
/// // With premium italic style
/// AppLogo(usePremiumStyle: true)
/// ```
class AppLogo extends StatelessWidget {
  /// Size of the logo image
  final double size;

  /// Whether to show the "Trusted" text
  final bool showText;

  /// Alignment of the logo content
  final MainAxisAlignment alignment;

  /// Color of the text (default: white)
  final Color? textColor;

  /// Whether to use premium/italic styling for the text
  final bool usePremiumStyle;

  const AppLogo({
    super.key,
    this.size = 48,
    this.showText = true,
    this.alignment = MainAxisAlignment.center,
    this.textColor,
    this.usePremiumStyle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      children: [
        // Logo image
        SvgPicture.asset('assets/images/logo.svg', width: size, height: size ,fit: BoxFit.contain,),
        SizedBox(width: AppSpacing.s),
        // Text label
        if (showText) ...[
          Text(
            'Trusted',
            style: AppTextStyles.heading1.copyWith(
              color: textColor ?? AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 32 / 24,
              fontStyle: usePremiumStyle ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ],
    );
  }
}
