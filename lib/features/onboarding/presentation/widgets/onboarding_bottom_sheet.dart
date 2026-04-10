import 'package:flutter/material.dart';
import '../../../../core/theme/app_padding.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import 'onboarding_progress.dart';

/// OnboardingBottomSheet - Bottom action area for onboarding
///
/// Contains progress indicator and action button
class OnboardingBottomSheet extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final bool isLoading;
  final VoidCallback onNext;

  const OnboardingBottomSheet({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.isLoading,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final isLastPage = currentPage == totalPages - 1;

    return Container(
      padding: const EdgeInsets.all(AppPadding.screenHorizontal),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OnboardingProgress(
            currentPage: currentPage,
            totalPages: totalPages,
          ),
          SizedBox(height: AppSpacing.m),
          PrimaryButton(
            text: isLastPage ? 'Get Started' : 'Next',
            onPressed: onNext,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}
