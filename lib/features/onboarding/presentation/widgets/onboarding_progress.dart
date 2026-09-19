import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';

class OnboardingProgress extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const OnboardingProgress({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderCol = theme.brightness == Brightness.dark 
        ? Colors.white12 
        : Colors.black12;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalPages, (index) {
          final isActive = index == currentPage;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs + 4),
            height: isActive ? 10 : 8,
            width: isActive ? 32 : 8,
            decoration: BoxDecoration(
              color: isActive ? theme.colorScheme.primary : borderCol,
              borderRadius: BorderRadius.circular(isActive ? 5 : 4),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.6),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
            ),
          );
        }),
      ),
    );
  }
}
