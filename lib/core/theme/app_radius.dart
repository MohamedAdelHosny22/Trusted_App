import 'package:flutter/painting.dart';

/// AppRadius - Trusted Design System Border Radius
///
/// Consistent border radius values for all UI components
class AppRadius {
  // Private constructor to prevent instantiation
  AppRadius._();

  // Standard radius values
  static const double xs = 4.0;   // Small elements, tags
  static const double s = 8.0;    // Small cards, chips
  static const double m = 12.0;   // Buttons, inputs
  static const double l = 16.0;   // Standard cards
  static const double xl = 24.0;  // Large containers
  static const double xxl = 32.0; // Modal dialogs
  static const double full = 999.0; // Full rounded (pill shape)

  // Component-specific radius
  static const double buttonRadius = m;
  static const double inputRadius = m;
  static const double cardRadius = l;
  static const double badgeRadius = full;
  static const double modalRadius = xl;
  static const double chipRadius = s;

  // BorderRadius objects for easy use
  static const Radius button = Radius.circular(m);
  static const Radius input = Radius.circular(m);
  static const Radius card = Radius.circular(l);
  static const Radius badge = Radius.circular(full);
  static const Radius modal = Radius.circular(xl);
  static const Radius chip = Radius.circular(s);

  // BorderRadius objects
  static final BorderRadius buttonBorder = BorderRadius.all(button);
  static final BorderRadius inputBorder = BorderRadius.all(input);
  static final BorderRadius cardBorder = BorderRadius.all(card);
  static final BorderRadius badgeBorder = BorderRadius.all(badge);
  static final BorderRadius modalBorder = BorderRadius.all(modal);
  static final BorderRadius chipBorder = BorderRadius.all(chip);

  // Asymmetric border radius (if needed)
  static BorderRadius topOnly(double radius) => BorderRadius.only(
    topLeft: Radius.circular(radius),
    topRight: Radius.circular(radius),
  );

  static BorderRadius bottomOnly(double radius) => BorderRadius.only(
    bottomLeft: Radius.circular(radius),
    bottomRight: Radius.circular(radius),
  );

  static BorderRadius leftOnly(double radius) => BorderRadius.only(
    topLeft: Radius.circular(radius),
    bottomLeft: Radius.circular(radius),
  );

  static BorderRadius rightOnly(double radius) => BorderRadius.only(
    topRight: Radius.circular(radius),
    bottomRight: Radius.circular(radius),
  );
}
