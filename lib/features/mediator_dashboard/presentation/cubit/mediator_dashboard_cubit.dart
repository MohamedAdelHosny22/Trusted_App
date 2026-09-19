import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/mediator_repository.dart';
import '../../data/models/payment_request_model.dart';
import '../../data/models/mediator_stats_model.dart';
import 'mediator_dashboard_state.dart';

/// MediatorDashboardCubit - State management for mediator dashboard
///
/// Responsibilities:
/// - Load payment requests
/// - Approve/reject payments
/// - Load mediator stats
/// - Manage dashboard state
class MediatorDashboardCubit extends Cubit<MediatorDashboardState> {
  final MediatorRepository _repository;

  MediatorDashboardCubit(this._repository)
      : super(const MediatorDashboardState.initial());

  /// Load initial dashboard data
  ///
  /// Fetches both payment requests and stats
  Future<void> loadDashboard() async {
    emit(state.asLoading());

    try {
      // Fetch payment requests and stats in parallel
      final results = await Future.wait([
        _repository.getPaymentRequests(),
        _repository.getMediatorStats(),
        _repository.getPendingRequestsCount(),
      ]);

      final requests = results[0] as List<PaymentRequestModel>;
      final stats = results[1] as MediatorStatsModel;
      final pendingCount = results[2] as int;

      emit(state.asLoaded(
        requests: requests,
        newStats: stats,
        newPendingCount: pendingCount,
      ));
    } catch (e) {
      emit(state.asError('Failed to load dashboard: $e'));
    }
  }

  /// Refresh payment requests only
  Future<void> refreshPaymentRequests() async {
    try {
      final requests = await _repository.getPaymentRequests();
      final pendingCount = await _repository.getPendingRequestsCount();

      emit(state.asLoaded(
        requests: requests,
        newPendingCount: pendingCount,
      ));
    } catch (e) {
      emit(state.asError('Failed to refresh requests: $e'));
    }
  }

  /// Approve a payment request
  ///
  /// Updates the request status and creates chat rooms
  Future<void> approvePayment(String requestId) async {
    try {
      await _repository.approvePaymentRequest(requestId);

      // Refresh the list
      await refreshPaymentRequests();
    } catch (e) {
      emit(state.asError('Failed to approve payment: $e'));
    }
  }

  /// Reject a payment request
  ///
  /// Updates the request status with rejection reason
  Future<void> rejectPayment(
    String requestId,
    String reason,
  ) async {
    try {
      await _repository.rejectPaymentRequest(requestId, reason);

      // Refresh the list
      await refreshPaymentRequests();
    } catch (e) {
      emit(state.asError('Failed to reject payment: $e'));
    }
  }

  /// Refresh stats only
  Future<void> refreshStats() async {
    try {
      final stats = await _repository.getMediatorStats();
      emit(state.asLoaded(newStats: stats));
    } catch (e) {
      emit(state.asError('Failed to refresh stats: $e'));
    }
  }

  /// Reset state to initial
  void reset() {
    emit(const MediatorDashboardState.initial());
  }
}
