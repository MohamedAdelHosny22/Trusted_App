import 'package:flutter/material.dart';
import 'app_colors.dart';

/// AppShadows - Trusted Design System Shadow Effects
///
/// Shadow definitions for depth, glow effects, and glassmorphism
class AppShadows {
  // Private constructor to prevent instantiation
  AppShadows._();

  // Standard elevation shadows
  static List<BoxShadow> get none => [];

  static List<BoxShadow> get xs => [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.05),
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get sm => [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.08),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get md => [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.12),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get lg => [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.15),
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get xl => [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.2),
      offset: const Offset(0, 12),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];

  // Glow Effects (Cyber aesthetic)
  static List<BoxShadow> get primaryGlow => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha:0.4),
      offset: const Offset(0, 0),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get primaryGlowStrong => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha:0.6),
      offset: const Offset(0, 0),
      blurRadius: 30,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> get goldGlow => [
    BoxShadow(
      color: AppColors.goldTier.withValues(alpha:0.4),
      offset: const Offset(0, 0),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get goldGlowStrong => [
    BoxShadow(
      color: AppColors.goldTier.withValues(alpha:0.6),
      offset: const Offset(0, 0),
      blurRadius: 30,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> get successGlow => [
    BoxShadow(
      color: AppColors.success.withValues(alpha:0.4),
      offset: const Offset(0, 0),
      blurRadius: 15,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get errorGlow => [
    BoxShadow(
      color: AppColors.error.withValues(alpha:0.4),
      offset: const Offset(0, 0),
      blurRadius: 15,
      spreadRadius: 0,
    ),
  ];

  // Glassmorphism Effect
  static List<BoxShadow> get glassmorphism => [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.1),
      offset: const Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];

  // Focus State Glow
  static List<BoxShadow> get focusGlow => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha:0.3),
      offset: const Offset(0, 0),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  // Pressed State Shadow
  static List<BoxShadow> get pressed => [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.2),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  // Card Shadows
  static List<BoxShadow> get card => sm;
  static List<BoxShadow> get cardHover => md;
  static List<BoxShadow> get mediatorCardGold => [
    BoxShadow(
      color: AppColors.goldTier.withValues(alpha:0.3),
      offset: const Offset(0, 0),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    ...sm,
  ];

  static List<BoxShadow> get mediatorCardElite => [
    BoxShadow(
      color: AppColors.eliteTier.withValues(alpha:0.3),
      offset: const Offset(0, 0),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    ...sm,
  ];
}
