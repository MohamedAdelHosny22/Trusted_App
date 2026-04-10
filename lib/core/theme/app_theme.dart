import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';
import 'app_radius.dart';

/// AppTheme - Trusted Design System Theme Configuration
///
/// Central theme configuration using all Design System constants
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Light theme (not used in dark-first design, but provided for completeness)
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      //background: AppColors.background,
      error: AppColors.error,
      onPrimary: AppColors.background,
      onSecondary: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      //onBackground: AppColors.textPrimary,
      onError: AppColors.textPrimary,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: _textTheme,
    appBarTheme: _appBarTheme,
    cardTheme: _cardTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
  );

  // Dark theme (primary theme for the app)
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      //background: AppColors.background,
      error: AppColors.error,
      onPrimary: AppColors.background,
      onSecondary: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      //onBackground: AppColors.textPrimary,
      onError: AppColors.textPrimary,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: _textTheme,
    appBarTheme: _appBarTheme,
    cardTheme: _cardTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
  );

  // Text Theme
  static TextTheme get _textTheme => TextTheme(
    displayLarge: AppTextStyles.heading1,
    displayMedium: AppTextStyles.heading2,
    displaySmall: AppTextStyles.heading3,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodySmall,
    bodySmall: AppTextStyles.caption,
    labelLarge: AppTextStyles.buttonText,
    labelMedium: AppTextStyles.bodySmall,
    labelSmall: AppTextStyles.caption,
  );

  // App Bar Theme
  static AppBarTheme get _appBarTheme => AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    titleTextStyle: AppTextStyles.heading2,
    iconTheme: const IconThemeData(
      color: AppColors.textPrimary,
      size: AppSpacing.iconSize,
    ),
    scrolledUnderElevation: 0,
  );

  // Card Theme
  static CardThemeData get _cardTheme => CardThemeData(
    elevation: 0,
    color: AppColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.cardBorder,
    ),
    margin: EdgeInsets.zero,
  );

  // Elevated Button Theme
  static ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.background,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.buttonHorizontal,
        vertical: AppSpacing.buttonVertical,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.buttonBorder,
      ),
      textStyle: AppTextStyles.buttonText,
      minimumSize: const Size(double.infinity, 56),
    ),
  );

  // Outlined Button Theme
  static OutlinedButtonThemeData get _outlinedButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.buttonHorizontal,
        vertical: AppSpacing.buttonVertical,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.buttonBorder,
      ),
      side: const BorderSide(
        color: AppColors.primary,
        width: 1,
      ),
      textStyle: AppTextStyles.buttonText.copyWith(
        color: AppColors.primary,
      ),
      minimumSize: const Size(double.infinity, 56),
    ),
  );

  // Input Decoration Theme
  static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    contentPadding: const EdgeInsets.all(AppSpacing.inputPadding),
    border: OutlineInputBorder(
      borderRadius: AppRadius.inputBorder,
      borderSide: const BorderSide(color: AppColors.border, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.inputBorder,
      borderSide: const BorderSide(color: AppColors.border, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppRadius.inputBorder,
      borderSide: const BorderSide(color: AppColors.primary, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: AppRadius.inputBorder,
      borderSide: const BorderSide(color: AppColors.error, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: AppRadius.inputBorder,
      borderSide: const BorderSide(color: AppColors.error, width: 1),
    ),
    hintStyle: AppTextStyles.bodyLargeWithColor(AppColors.textSecondary),
    errorStyle: AppTextStyles.bodySmallWithColor(AppColors.error),
  );

  // Bottom Navigation Bar Theme
  static BottomNavigationBarThemeData get _bottomNavigationBarTheme => BottomNavigationBarThemeData(
    backgroundColor: AppColors.background.withValues(alpha:0.9),
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textSecondary,
    selectedLabelStyle: AppTextStyles.bodySmall,
    unselectedLabelStyle: AppTextStyles.bodySmall,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  );
}
