import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// AppAuthBackground - Reusable gradient background for auth screens
///
/// Features:
/// - Consistent gradient across all auth screens
/// - Primary color fade at top
/// - Neutral background at bottom
///
/// Usage:
/// ```dart
/// Stack(
///   children: [
///     const AppAuthBackground(),
///     // ... content
///   ],
/// )
/// ```
class AppAuthBackground extends StatelessWidget {
  const AppAuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withValues(alpha: 0.05),
            AppColors.background,
          ],
        ),
      ),
    );
  }
}
