import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';

/// OnboardingCubit - Onboarding business logic
///
/// Responsibilities:
/// - Manage page navigation
/// - Complete onboarding
/// - Emit state changes
///
/// NOT responsible for:
/// - Navigation (UI handles via BlocListener)
/// - UI animations
/// - PageController management
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  /// Move to next page or complete onboarding
  void nextPage() {
    if (state.isLastPage) {
      completeOnboarding();
    } else {
      emit(state.nextPage());
    }
  }

  /// Move to previous page
  void previousPage() {
    if (!state.isFirstPage) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }

  /// Move to specific page
  void goToPage(int page) {
    if (page >= 0 && page < state.totalPages) {
      emit(state.copyWith(currentPage: page));
    }
  }

  /// Complete onboarding and persist
  Future<void> completeOnboarding() async {
    emit(state.asLoading());

    try {
      // Simulate saving onboarding status
      // In production, this would save to storage
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.asCompleted());
    } catch (e) {
      emit(state.asFailure('Failed to complete onboarding'));
    }
  }

  /// Skip onboarding
  void skip() {
    // TODO: Implement skip logic
    completeOnboarding();
  }

  /// Reset state (useful for testing)
  void reset() {
    emit(const OnboardingState());
  }
}
