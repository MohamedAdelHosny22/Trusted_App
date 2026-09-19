/// PaymentRequestStatus - Status of a payment approval request
enum PaymentRequestStatus {
  /// Payment awaiting mediator review
  pending,

  /// Payment approved by mediator
  approved,

  /// Payment rejected by mediator
  rejected,
}

/// PaymentRequestModel - Payment awaiting mediator approval
///
/// Represents a user's payment that needs mediator verification
class PaymentRequestModel {
  final String id;
  final String buyerId;
  final String buyerName;
  final String? buyerAvatar;
  final String sellerId;
  final String sellerName;
  final String? sellerAvatar;
  final String accountId;
  final String accountTitle;
  final double amount;
  final String screenshotPath;
  final DateTime createdAt;
  final PaymentRequestStatus status;
  final String? rejectionReason;
  final DateTime? reviewedAt;

  const PaymentRequestModel({
    required this.id,
    required this.buyerId,
    required this.buyerName,
    this.buyerAvatar,
    required this.sellerId,
    required this.sellerName,
    this.sellerAvatar,
    required this.accountId,
    required this.accountTitle,
    required this.amount,
    required this.screenshotPath,
    required this.createdAt,
    required this.status,
    this.rejectionReason,
    this.reviewedAt,
  });

  factory PaymentRequestModel.fromJson(Map<String, dynamic> json) {
    return PaymentRequestModel(
      id: json['id'] as String,
      buyerId: json['buyer_id'] as String,
      buyerName: json['buyer_name'] as String,
      buyerAvatar: json['buyer_avatar'] as String?,
      sellerId: json['seller_id'] as String,
      sellerName: json['seller_name'] as String,
      sellerAvatar: json['seller_avatar'] as String?,
      accountId: json['account_id'] as String,
      accountTitle: json['account_title'] as String,
      amount: (json['amount'] as num).toDouble(),
      screenshotPath: json['screenshot_path'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: PaymentRequestStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => PaymentRequestStatus.pending,
      ),
      rejectionReason: json['rejection_reason'] as String?,
      reviewedAt: json['reviewed_at'] != null
          ? DateTime.parse(json['reviewed_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyer_id': buyerId,
      'buyer_name': buyerName,
      'buyer_avatar': buyerAvatar,
      'seller_id': sellerId,
      'seller_name': sellerName,
      'seller_avatar': sellerAvatar,
      'account_id': accountId,
      'account_title': accountTitle,
      'amount': amount,
      'screenshot_path': screenshotPath,
      'created_at': createdAt.toIso8601String(),
      'status': status.name,
      'rejection_reason': rejectionReason,
      'reviewed_at': reviewedAt?.toIso8601String(),
    };
  }

  PaymentRequestModel copyWith({
    String? id,
    String? buyerId,
    String? buyerName,
    String? buyerAvatar,
    String? sellerId,
    String? sellerName,
    String? sellerAvatar,
    String? accountId,
    String? accountTitle,
    double? amount,
    String? screenshotPath,
    DateTime? createdAt,
    PaymentRequestStatus? status,
    String? rejectionReason,
    DateTime? reviewedAt,
  }) {
    return PaymentRequestModel(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      buyerName: buyerName ?? this.buyerName,
      buyerAvatar: buyerAvatar ?? this.buyerAvatar,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      sellerAvatar: sellerAvatar ?? this.sellerAvatar,
      accountId: accountId ?? this.accountId,
      accountTitle: accountTitle ?? this.accountTitle,
      amount: amount ?? this.amount,
      screenshotPath: screenshotPath ?? this.screenshotPath,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      reviewedAt: reviewedAt ?? this.reviewedAt,
    );
  }

  /// Check if request is pending
  bool get isPending => status == PaymentRequestStatus.pending;

  /// Check if request is approved
  bool get isApproved => status == PaymentRequestStatus.approved;

  /// Check if request is rejected
  bool get isRejected => status == PaymentRequestStatus.rejected;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentRequestModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
