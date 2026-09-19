import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void nextPage() {
    if (state.isLastPage) {
      completeOnboarding();
    } else {
      emit(state.nextPage());
    }
  }
  void previousPage() {
    if (!state.isFirstPage) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }
  void goToPage(int page) {
    if (page >= 0 && page < state.totalPages) {
      emit(state.copyWith(currentPage: page));
    }
  }

  Future<void> completeOnboarding() async {
    emit(state.asLoading());

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.asCompleted());
    } catch (e) {
      emit(state.asFailure('Failed to complete onboarding'));
    }
  }
  void skip() {
    completeOnboarding();
  }
  void reset() {
    emit(const OnboardingState());
  }
}
