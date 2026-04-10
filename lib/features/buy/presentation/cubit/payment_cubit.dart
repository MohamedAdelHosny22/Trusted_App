import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_state.dart';

/// PaymentCubit - Manages payment flow state
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentState());

  /// Upload screenshot proof
  void uploadScreenshot(String path) {
    emit(state.copyWith(
      screenshotPath: path,
      errorMessage: null,
    ));
  }

  /// Clear screenshot
  void clearScreenshot() {
    emit(state.copyWith(
      screenshotPath: null,
      errorMessage: null,
    ));
  }

  /// Confirm payment
  void confirmPayment() {
    emit(state.copyWith(isConfirming: true));
    // TODO: Send payment confirmation to backend
    // For now, just emit success
    emit(state.copyWith(isConfirming: false));
  }

  /// Reset state
  void reset() {
    emit(const PaymentState());
  }
}
