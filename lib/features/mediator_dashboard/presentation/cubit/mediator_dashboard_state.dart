import 'package:equatable/equatable.dart';
import '../../data/models/payment_request_model.dart';
import '../../data/models/mediator_stats_model.dart';

/// MediatorDashboardState - State for mediator dashboard
///
/// Follows unidirectional data flow pattern
/// States: initial, loading, loaded, error
class MediatorDashboardState extends Equatable {
  final LoadingStatus loadingStatus;
  final List<PaymentRequestModel> paymentRequests;
  final MediatorStatsModel? stats;
  final int pendingCount;
  final String? errorMessage;

  const MediatorDashboardState({
    this.loadingStatus = LoadingStatus.initial,
    this.paymentRequests = const [],
    this.stats,
    this.pendingCount = 0,
    this.errorMessage,
  });

  /// Initial state
  const MediatorDashboardState.initial()
      : loadingStatus = LoadingStatus.initial,
        paymentRequests = const [],
        stats = null,
        pendingCount = 0,
        errorMessage = null;

  /// Loading state
  MediatorDashboardState asLoading() {
    return MediatorDashboardState(
      loadingStatus: LoadingStatus.loading,
      paymentRequests: paymentRequests,
      stats: stats,
      pendingCount: pendingCount,
    );
  }

  /// Loaded state
  MediatorDashboardState asLoaded({
    List<PaymentRequestModel>? requests,
    MediatorStatsModel? newStats,
    int? newPendingCount,
  }) {
    return MediatorDashboardState(
      loadingStatus: LoadingStatus.loaded,
      paymentRequests: requests ?? paymentRequests,
      stats: newStats ?? stats,
      pendingCount: newPendingCount ?? pendingCount,
    );
  }

  /// Error state
  MediatorDashboardState asError(String message) {
    return MediatorDashboardState(
      loadingStatus: LoadingStatus.error,
      paymentRequests: paymentRequests,
      stats: stats,
      pendingCount: pendingCount,
      errorMessage: message,
    );
  }

  /// Check if current state is loading
  bool get isLoading => loadingStatus == LoadingStatus.loading;

  /// Check if current state is loaded
  bool get isLoaded => loadingStatus == LoadingStatus.loaded;

  /// Check if current state has error
  bool get hasError => loadingStatus == LoadingStatus.error;

  /// Get only pending requests
  List<PaymentRequestModel> get pendingRequests =>
      paymentRequests.where((r) => r.isPending).toList();

  /// Get only approved requests
  List<PaymentRequestModel> get approvedRequests =>
      paymentRequests.where((r) => r.isApproved).toList();

  /// Get only rejected requests
  List<PaymentRequestModel> get rejectedRequests =>
      paymentRequests.where((r) => r.isRejected).toList();

  @override
  List<Object?> get props => [
        loadingStatus,
        paymentRequests,
        stats,
        pendingCount,
        errorMessage,
      ];
}

/// LoadingStatus enum for state machine
enum LoadingStatus {
  initial,
  loading,
  loaded,
  error,
}
