import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/onboarding_bottom_sheet.dart';
import '../widgets/onboarding_page_view.dart';
import '../widgets/onboarding_top_bar.dart';

/// OnboardingScreen - App onboarding flow
///
/// Features:
/// - Multi-page onboarding experience
/// - Progress indicators
/// - Navigation controls
/// - Completion tracking
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
  int _currentPage = 0;

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

    if (_currentPage != state.currentPage && _pageController.hasClients) {
      _pageController.animateToPage(
        state.currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _currentPage = state.currentPage;
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
    setState(() {
      _currentPage = page;
    });
    context.read<OnboardingCubit>().goToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
