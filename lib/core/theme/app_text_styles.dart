import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// AppTextStyles - Trusted Design System Typography
///
/// Font Family: Space Grotesk (English) / Inter (Fallback)
/// RTL Support: All styles are mirrored for Arabic
class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();

  // Heading Styles
  static TextStyle get heading1 => GoogleFonts.spaceGrotesk(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 34 / 28,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle get heading2 => GoogleFonts.spaceGrotesk(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 28 / 22,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static TextStyle get heading3 => GoogleFonts.spaceGrotesk(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  // Body Styles
  static TextStyle get body => GoogleFonts.spaceGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.textPrimary,
    letterSpacing: 0,
  );

  static TextStyle get bodyLarge => GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 22 / 16,
    color: AppColors.textPrimary,
    letterSpacing: 0,
  );

  static TextStyle get bodySmall => GoogleFonts.spaceGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    color: AppColors.textSecondary,
    letterSpacing: 0.1,
  );

  // Button Text
  static TextStyle get buttonText => GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 20 / 16,
    letterSpacing: 0.2,
  );

  // Caption
  static TextStyle get caption => GoogleFonts.spaceGrotesk(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    color: AppColors.textSecondary,
    letterSpacing: 0.3,
  );

  // Color Variants
  static TextStyle heading1WithColor(Color color) => heading1.copyWith(color: color);
  static TextStyle heading2WithColor(Color color) => heading2.copyWith(color: color);
  static TextStyle heading3WithColor(Color color) => heading3.copyWith(color: color);
  static TextStyle bodyLargeWithColor(Color color) => bodyLarge.copyWith(color: color);
  static TextStyle bodySmallWithColor(Color color) => bodySmall.copyWith(color: color);

  // Primary Color Variants
  static TextStyle get heading1Primary => heading1WithColor(AppColors.primary);
  static TextStyle get heading2Primary => heading2WithColor(AppColors.primary);
  static TextStyle get heading3Primary => heading3WithColor(AppColors.primary);
  static TextStyle get bodyLargePrimary => bodyLargeWithColor(AppColors.primary);
  static TextStyle get bodySmallPrimary => bodySmallWithColor(AppColors.primary);

  // Success/Error/Warning Variants
  static TextStyle get bodyLargeSuccess => bodyLargeWithColor(AppColors.success);
  static TextStyle get bodyLargeError => bodyLargeWithColor(AppColors.error);
  static TextStyle get bodyLargeWarning => bodyLargeWithColor(AppColors.warning);

  // Override Colors for Button Text
  static TextStyle get primaryButtonText => buttonText.copyWith(color: AppColors.background);
  static TextStyle get secondaryButtonText => buttonText.copyWith(color: AppColors.primary);

  // Link Text (for navigation links, forgot password, etc.)
  static TextStyle get linkText => GoogleFonts.spaceGrotesk(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    color: AppColors.primary.withValues(alpha: 0.6),
    letterSpacing: 0,
  );

  static TextStyle get linkTextActive => GoogleFonts.spaceGrotesk(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    color: AppColors.primary,
    letterSpacing: 0,
  );

  // Error Text (for validation messages)
  static TextStyle get errorText => GoogleFonts.spaceGrotesk(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    color: AppColors.error,
    letterSpacing: 0,
  );

  // Label Text (for input field labels)
  static TextStyle get labelText => GoogleFonts.spaceGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    color: AppColors.textSecondary,
    letterSpacing: 0.1,
  );

  // Figma Design Tokens - Profile Screen
  static TextStyle get labelUppercase => GoogleFonts.spaceGrotesk(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    height: 15 / 10,
    color: AppColors.textTertiary,
    letterSpacing: 1.0,
  );

  static TextStyle get statsNumber => GoogleFonts.spaceGrotesk(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    height: 32 / 24,
    color: AppColors.textBright,
    letterSpacing: 0,
  );

  static TextStyle get statsSubtitle => GoogleFonts.spaceGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    color: AppColors.primary,
    letterSpacing: 0,
  );

  static TextStyle get cardTitle => GoogleFonts.spaceGrotesk(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 16 / 12,
    color: AppColors.textBright,
    letterSpacing: 0,
  );

  static TextStyle get smallMediumText => GoogleFonts.spaceGrotesk(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 15 / 10,
    color: AppColors.textTertiary,
    letterSpacing: 0,
  );
}
