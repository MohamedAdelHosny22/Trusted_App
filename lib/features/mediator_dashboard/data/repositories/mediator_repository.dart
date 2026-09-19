import '../models/payment_request_model.dart';
import '../models/mediator_stats_model.dart';
import '../datasources/mediator_local_data_source.dart';

// Export PaymentRequestStatus from model for convenience
export '../models/payment_request_model.dart' show PaymentRequestStatus;

/// MediatorRepository - Repository for mediator operations
///
/// Abstract contract for mediator-related business logic
abstract class MediatorRepository {
  /// Get all payment requests for the mediator
  Future<List<PaymentRequestModel>> getPaymentRequests();

  /// Get payment request by ID
  Future<PaymentRequestModel?> getPaymentRequestById(String id);

  /// Approve a payment request
  Future<PaymentRequestModel> approvePaymentRequest(String id);

  /// Reject a payment request
  Future<PaymentRequestModel> rejectPaymentRequest(
    String id,
    String reason,
  );

  /// Get mediator statistics
  Future<MediatorStatsModel> getMediatorStats();

  /// Get pending requests count
  Future<int> getPendingRequestsCount();
}

/// MediatorRepositoryImpl - Concrete implementation
class MediatorRepositoryImpl implements MediatorRepository {
  final MediatorLocalDataSource _localDataSource;

  MediatorRepositoryImpl({
    required MediatorLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  Future<List<PaymentRequestModel>> getPaymentRequests() {
    return _localDataSource.getPaymentRequests();
  }

  @override
  Future<PaymentRequestModel?> getPaymentRequestById(String id) {
    return _localDataSource.getPaymentRequestById(id);
  }

  @override
  Future<PaymentRequestModel> approvePaymentRequest(String id) {
    return _localDataSource.updatePaymentRequest(
      id,
      PaymentRequestStatus.approved,
    );
  }

  @override
  Future<PaymentRequestModel> rejectPaymentRequest(
    String id,
    String reason,
  ) {
    return _localDataSource.updatePaymentRequest(
      id,
      PaymentRequestStatus.rejected,
      rejectionReason: reason,
    );
  }

  @override
  Future<MediatorStatsModel> getMediatorStats() {
    return _localDataSource.getMediatorStats();
  }

  @override
  Future<int> getPendingRequestsCount() {
    return _localDataSource.getPendingRequestsCount();
  }
}

