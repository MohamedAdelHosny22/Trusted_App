/// SplashStatus - Splash screen navigation status
enum SplashStatus {
  initial,      // Initial state
  checking,     // Checking auth status
  navigateHome, // Navigate to home (authenticated)
  navigateOnboarding, // Navigate to onboarding (first time)
  navigateLogin, // Navigate to login (returning user)
}

/// SplashState - Splash screen state
class SplashState {
  final SplashStatus status;

  const SplashState({this.status = SplashStatus.initial});

  SplashState copyWith({SplashStatus? status}) {
    return SplashState(status: status ?? this.status);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SplashState && other.status == status;

  @override
  int get hashCode => status.hashCode;
}
