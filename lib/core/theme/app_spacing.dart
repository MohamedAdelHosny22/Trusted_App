/// AppSpacing - Trusted Design System Spacing Scale
///
/// Based on an 8px grid system for consistency
class AppSpacing {
  // Private constructor to prevent instantiation
  AppSpacing._();

  // Spacing Scale (8px grid)
  static const double xs = 4.0;   // Tight grouping (e.g., icon and label)
  static const double s = 8.0;    // Element spacing within components
  static const double m = 16.0;   // Standard padding for cards and screen margins
  static const double l = 24.0;   // Spacing between major sections
  static const double xl = 32.0;  // Hero section margins

  // Additional spacing values
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // Component-specific spacing
  static const double buttonHorizontal = m;
  static const double buttonVertical = s;
  static const double cardPadding = m;
  static const double inputPadding = m;
  static const double iconLabelSpacing = xs;
  static const double listSpacing = s;

  // Screen-specific spacing
  static const double screenPadding = m;
  static const double sectionSpacing = l;

  // Icon spacing
  static const double iconSpacing = s;
  static const double iconSizeSmall = 16.0;
  static const double iconSize = 24.0;
  static const double iconSizeLarge = 32.0;
}
