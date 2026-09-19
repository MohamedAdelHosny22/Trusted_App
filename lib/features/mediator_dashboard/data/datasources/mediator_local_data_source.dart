import '../models/payment_request_model.dart';
import '../models/mediator_stats_model.dart';

/// MediatorLocalDataSource - Local data source for mediator operations
///
/// Mock implementation simulates database operations
/// In production, replace with actual API or database calls
class MediatorLocalDataSource {
  MediatorLocalDataSource();

  /// Mock payment requests storage
  final List<PaymentRequestModel> _paymentRequests = [];

  /// Get all payment requests for the mediator
  Future<List<PaymentRequestModel>> getPaymentRequests() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return mock data
    if (_paymentRequests.isEmpty) {
      return _getMockPaymentRequests();
    }

    return List.from(_paymentRequests);
  }

  /// Get payment request by ID
  Future<PaymentRequestModel?> getPaymentRequestById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      return _paymentRequests.firstWhere((request) => request.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Update payment request status (approve/reject)
  Future<PaymentRequestModel> updatePaymentRequest(
    String id,
    PaymentRequestStatus status, {
    String? rejectionReason,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final index = _paymentRequests.indexWhere((request) => request.id == id);

      // Check if request was found
      if (index < 0 || index >= _paymentRequests.length) {
        throw Exception('Payment request with ID "$id" not found');
      }

      final updatedRequest = _paymentRequests[index].copyWith(
        status: status,
        rejectionReason: rejectionReason,
        reviewedAt: DateTime.now(),
      );

      _paymentRequests[index] = updatedRequest;
      return updatedRequest;
    } catch (e) {
      throw Exception('Failed to update payment request: $e');
    }
  }

  /// Get mediator stats
  Future<MediatorStatsModel> getMediatorStats() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return MediatorStatsModel.mock();
  }

  /// Get pending requests count
  Future<int> getPendingRequestsCount() async {
    await Future.delayed(const Duration(milliseconds: 100));

    final requests = await getPaymentRequests();
    return requests.where((r) => r.isPending).length;
  }

  /// Mock payment requests for testing
  List<PaymentRequestModel> _getMockPaymentRequests() {
    return [
      PaymentRequestModel(
        id: 'pr-001',
        buyerId: 'user-001',
        buyerName: 'Ahmed Ali',
        buyerAvatar: 'https://i.pravatar.cc/150?img=11',
        sellerId: 'user-002',
        sellerName: 'Mohamed Hassan',
        sellerAvatar: 'https://i.pravatar.cc/150?img=12',
        accountId: 'account-001',
        accountTitle: 'PUBG Mobile Ace Account',
        amount: 1500.0,
        screenshotPath: '/mock/screenshots/payment_001.jpg',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        status: PaymentRequestStatus.pending,
      ),
      PaymentRequestModel(
        id: 'pr-002',
        buyerId: 'user-003',
        buyerName: 'Sara Mohamed',
        buyerAvatar: 'https://i.pravatar.cc/150?img=20',
        sellerId: 'user-004',
        sellerName: 'Omar Khaled',
        sellerAvatar: 'https://i.pravatar.cc/150?img=33',
        accountId: 'account-002',
        accountTitle: 'Free Fire Max Elite Pass',
        amount: 800.0,
        screenshotPath: '/mock/screenshots/payment_002.jpg',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        status: PaymentRequestStatus.pending,
      ),
      PaymentRequestModel(
        id: 'pr-003',
        buyerId: 'user-005',
        buyerName: 'Nour Ahmed',
        buyerAvatar: 'https://i.pravatar.cc/150?img=25',
        sellerId: 'user-006',
        sellerName: 'Youssef Sayed',
        sellerAvatar: 'https://i.pravatar.cc/150?img=14',
        accountId: 'account-003',
        accountTitle: 'Clash of Legends TH15',
        amount: 2200.0,
        screenshotPath: '/mock/screenshots/payment_003.jpg',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        status: PaymentRequestStatus.approved,
        reviewedAt: DateTime.now().subtract(const Duration(hours: 20)),
      ),
      PaymentRequestModel(
        id: 'pr-004',
        buyerId: 'user-007',
        buyerName: 'Layla Karem',
        buyerAvatar: 'https://i.pravatar.cc/150?img=26',
        sellerId: 'user-008',
        sellerName: 'Hassan Maher',
        sellerAvatar: 'https://i.pravatar.cc/150?img=15',
        accountId: 'account-004',
        accountTitle: 'Mobile Legends Mythic',
        amount: 950.0,
        screenshotPath: '/mock/screenshots/payment_004.jpg',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        status: PaymentRequestStatus.rejected,
        rejectionReason: 'Screenshot unclear - please upload a clearer image',
        reviewedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }
}

