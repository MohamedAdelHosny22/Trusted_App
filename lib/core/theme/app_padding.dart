import 'package:flutter/widgets.dart';

/// AppPadding - Trusted Design System Padding Scale
///
/// Standardized padding values for consistent layouts across all screens
class AppPadding {
  // Private constructor to prevent instantiation
  AppPadding._();

  // Screen-level padding (main content margins)
  static const double screenHorizontal = 32.0;  // Horizontal margins for screens
  static const double screenVertical = 32.0;    // Vertical margins for screens

  // Section padding (spacing between major sections)
  static const double section = 48.0;           // Space between major sections
  static const double subsection = 24.0;        // Space between subsections

  // Component padding
  static const double card = 16.0;              // Internal padding for cards
  static const double button = 16.0;            // Internal padding for buttons
  static const double input = 16.0;             // Internal padding for inputs

  // Edge cases
  static const double bottomSheet = 24.0;       // Bottom sheet content padding
  static const double dialog = 24.0;            // Dialog content padding

  // EdgeInsets shortcuts for common use cases
  static const EdgeInsets screenAll = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
    vertical: screenVertical,
  );

  static const EdgeInsets screenHorizontalOnly = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
  );

  static const EdgeInsets screenVerticalOnly = EdgeInsets.symmetric(
    vertical: screenVertical,
  );

  static const EdgeInsets sectionBottom = EdgeInsets.only(bottom: section);
  static const EdgeInsets cardAll = EdgeInsets.all(card);
}
