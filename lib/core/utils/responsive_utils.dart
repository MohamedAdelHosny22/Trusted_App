import 'package:flutter/widgets.dart';

/// ResponsiveUtils - Helper methods for responsive UI
///
/// Provides utilities to scale UI elements based on screen size
class ResponsiveUtils {
  ResponsiveUtils._();

  /// Scale font size based on screen width
  ///
  /// Returns a font size scaled proportionally to the screen width
  /// Base width is 375 (iPhone 12/13 Pro width)
  static double scaleFontSize(BuildContext context, double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    const baseWidth = 375.0;
    final scaleFactor = screenWidth / baseWidth;

    // Clamp scale factor between 0.8 and 1.2 to prevent extreme sizing
    final clampedScale = scaleFactor.clamp(0.8, 1.2);

    return baseFontSize * clampedScale;
  }

  /// Scale spacing based on screen height
  ///
  /// Returns a spacing value scaled proportionally to screen height
  static double scaleSpacing(BuildContext context, double baseSpacing) {
    final screenHeight = MediaQuery.of(context).size.height;
    const baseHeight = 812.0; // iPhone 12/13 Pro height
    final scaleFactor = screenHeight / baseHeight;

    // Clamp scale factor between 0.7 and 1.3
    final clampedScale = scaleFactor.clamp(0.7, 1.3);

    return baseSpacing * clampedScale;
  }

  /// Check if device is a small screen (width < 375)
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 375;
  }

  /// Check if device is a large screen (width > 600)
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }
}
