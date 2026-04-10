import 'package:equatable/equatable.dart';

/// PaymentState - State for payment flow
class PaymentState extends Equatable {
  final String? screenshotPath;
  final bool isUploading;
  final bool isConfirming;
  final String? errorMessage;

  const PaymentState({
    this.screenshotPath,
    this.isUploading = false,
    this.isConfirming = false,
    this.errorMessage,
  });

  PaymentState copyWith({
    String? screenshotPath,
    bool? isUploading,
    bool? isConfirming,
    String? errorMessage,
  }) {
    return PaymentState(
      screenshotPath: screenshotPath ?? this.screenshotPath,
      isUploading: isUploading ?? this.isUploading,
      isConfirming: isConfirming ?? this.isConfirming,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [screenshotPath, isUploading, isConfirming, errorMessage];
}
