import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// SplashBackground - Background gradient for splash screen
///
/// Consistent gradient across all splash screens
class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

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
