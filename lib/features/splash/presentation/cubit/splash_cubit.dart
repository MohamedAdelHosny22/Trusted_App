import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

/// SplashCubit - Splash screen business logic
///
/// Responsibilities:
/// - Check authentication status
/// - Determine navigation destination
/// - Emit appropriate state for navigation
///
/// NOT responsible for:
/// - Navigation (UI handles via BlocListener)
/// - UI rendering
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  /// Initialize splash screen and determine navigation
  ///
  /// Simulates checking auth status with delay
  /// In production, this would check actual auth state
  Future<void> initialize() async {
    emit(state.copyWith(status: SplashStatus.checking));

    // Simulate delay for auth check
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Check actual auth status here
    // For now, default to onboarding
    _determineNavigation(
      isAuthenticated: false,
      isFirstTime: true,
    );
  }

  void _determineNavigation({
    required bool isAuthenticated,
    required bool isFirstTime,
  }) {
    if (isClosed) return;

    if (isAuthenticated) {
      emit(state.copyWith(status: SplashStatus.navigateHome));
    } else if (isFirstTime) {
      emit(state.copyWith(status: SplashStatus.navigateOnboarding));
    } else {
      emit(state.copyWith(status: SplashStatus.navigateLogin));
    }
  }
}
