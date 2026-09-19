import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';
import '../../../../core/models/user_role.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  Future<void> initialize() async {
    emit(state.copyWith(status: SplashStatus.checking));

    await Future.delayed(const Duration(seconds: 2));

    _determineNavigation(
      isAuthenticated: false,
      isFirstTime: true,
      userRole: null,
    );
  }

  void setAuthenticatedWithRole(UserRole role) {
    if (isClosed) return;

    emit(state.copyWith(
      status: SplashStatus.checking,
      userRole: role,
    ));

    Future.delayed(const Duration(milliseconds: 500), () {
      if (isClosed) return;

      if (role == UserRole.mediator) {
        emit(state.copyWith(status: SplashStatus.navigateMediator));
      } else {
        emit(state.copyWith(status: SplashStatus.navigateHome));
      }
    });
  }

  void _determineNavigation({
    required bool isAuthenticated,
    required bool isFirstTime,
    required UserRole? userRole,
  }) {
    if (isClosed) return;

    if (isAuthenticated) {
      if (userRole == UserRole.mediator) {
        emit(state.copyWith(
          status: SplashStatus.navigateMediator,
          userRole: userRole,
        ));
      } else {
        emit(state.copyWith(
          status: SplashStatus.navigateHome,
          userRole: userRole ?? UserRole.user,
        ));
      }
    } else if (isFirstTime) {
      emit(state.copyWith(status: SplashStatus.navigateOnboarding));
    } else {
      emit(state.copyWith(status: SplashStatus.navigateLogin));
    }
  }
}
