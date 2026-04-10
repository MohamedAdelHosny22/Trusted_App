import 'package:flutter/material.dart';

/// AppColors - Trusted Design System Color Palette
///
/// Modern Cyber-Gaming aesthetic with dark-mode base and neon accents
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFF00EEFF); // Cyber Cyan - Brand / CTA
  static const Color secondary = Color(0xFF0A1F24); // Deep Teal - Surface / Accents

  // Background Colors
  static const Color background = Color(0xFF061012); // Main backdrop
  static const Color surface = Color(0xFF112328); // Layering, secondary containers

  // Status Colors
  static const Color success = Color(0xFF00FF9D); // Success messages, completed status
  static const Color error = Color(0xFFFF4B4B); // Error messages, cancelled status
  static const Color warning = Color(0xFFFFD700); // Premium, gold tier, alerts

  // UI Colors
  static const Color border = Color(0xFF1E3A42); // Input borders, dividers

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF); // Headings, main body
  static const Color textSecondary = Color(0xFFA0A0A0); // Subtitles, labels, captions

  // Accent Colors
  static const Color accentGreen = Color(0xFF00D084); // Price highlights, positive actions
  static const Color accentPurple = Color(0xFF9D4EDD); // Special offers, featured

  // Status Background Tints (10% opacity)
  static Color get successBackground => success.withValues(alpha:0.1);
  static Color get warningBackground => warning.withValues(alpha:0.1);
  static Color get errorBackground => error.withValues(alpha:0.1);

  // Mediator Tier Colors
  static const Color goldTier = Color(0xFFFFD700);
  static const Color eliteTier = Color(0xFF00EEFF);

  // Button States
  static Color get disabledBackground => primary.withValues(alpha:0.3);

  // Material Design Theme Mapping
  static const MaterialColor primaryMaterial = MaterialColor(
    0xFF00EEFF,
    <int, Color>{
      50: Color(0xFFE6FEFF),
      100: Color(0xFFCCFEFF),
      200: Color(0xFF99FDFF),
      300: Color(0xFF66FCFF),
      400: Color(0xFF33FBFF),
      500: Color(0xFF00EEFF),
      600: Color(0xFF008C99),
      700: Color(0xFF005966),
      800: Color(0xFF003333),
      900: Color(0xFF001A1A),
    },
  );

  // Figma Design Tokens - Profile Screen
  static const Color cardSurface = Color(0xFF1E3A42); // Stats/Trade card background
  static const Color priceGreen = Color(0xFF39FF00); // Price highlight green
  static const Color statusSuccess = Color(0xFF10B981); // Status icon green
  static const Color textTertiary = Color(0xFF94A3B8); // Subtle text labels
  static const Color borderSubtle = Color(0xFF334155); // Subtle borders
  static const Color textBright = Color(0xFFF2F6F9); // Bright white text
}
