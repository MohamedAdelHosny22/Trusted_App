import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

class OnboardingTopBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onSkip;

  const OnboardingTopBar({
    super.key,
    required this.onBack,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.m),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!state.isFirstPage)
                  IconButton(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back),
                    color: Theme.of(context).colorScheme.primary,
                  )
                else
                  const SizedBox(width: 48),
                if (state.isFirstPage || state.currentPage == 1)
                  TextActionButton(
                    text: 'Skip',
                    onPressed: onSkip,
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                  )
                else
                  const SizedBox(width: 48),
              ],
            ),
          ),
        );
      },
    );
  }
}
