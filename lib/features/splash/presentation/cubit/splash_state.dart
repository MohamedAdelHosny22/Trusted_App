import '../../../../core/models/user_role.dart';
enum SplashStatus {
  initial,
  checking,
  navigateHome,
  navigateMediator,
  navigateOnboarding,
  navigateLogin,
}

class SplashState {
  final SplashStatus status;
  final UserRole? userRole;

  const SplashState({
    this.status = SplashStatus.initial,
    this.userRole,
  });

  SplashState copyWith({
    SplashStatus? status,
    UserRole? userRole,
  }) {
    return SplashState(
      status: status ?? this.status,
      userRole: userRole ?? this.userRole,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SplashState &&
          other.status == status &&
          other.userRole == userRole;

  @override
  int get hashCode => status.hashCode ^ userRole.hashCode;
}
