import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/onboarding_bottom_sheet.dart';
import '../widgets/onboarding_page_view.dart';
import '../widgets/onboarding_top_bar.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const _OnboardingContent(),
    );
  }
}

class _OnboardingContent extends StatefulWidget {
  const _OnboardingContent();

  @override
  State<_OnboardingContent> createState() => _OnboardingContentState();
}

class _OnboardingContentState extends State<_OnboardingContent> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _listenToOnboardingState(BuildContext context, OnboardingState state) {
    if (state.isCompleted) {
      context.go('/auth/login');
    }

    if (_pageController.hasClients) {
      final currentViewPage = _pageController.page?.round() ?? 0;
      if (currentViewPage != state.currentPage) {
        _pageController.animateToPage(
          state.currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _handleNext() {
    context.read<OnboardingCubit>().nextPage();
  }

  void _handleBack() {
    context.read<OnboardingCubit>().previousPage();
  }

  void _handleSkip() {
    context.read<OnboardingCubit>().skip();
  }

  void _onPageChanged(int page) {
    context.read<OnboardingCubit>().goToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: _listenToOnboardingState,
        builder: (context, state) {
          return Column(
            children: [
              OnboardingTopBar(
                onBack: _handleBack,
                onSkip: _handleSkip,
              ),

              Expanded(
                child: OnboardingPageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                ),
              ),

              OnboardingBottomSheet(
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                isLoading: state.isLoading,
                onNext: _handleNext,
              ),
            ],
          );
        },
      ),
    );
  }
}
