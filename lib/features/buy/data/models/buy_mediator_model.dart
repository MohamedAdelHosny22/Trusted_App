/// MediatorTier - Mediator membership tier
enum MediatorTier {
  bronze,
  silver,
  gold,
  elite,
}

/// MediatorBadge - Achievement badges for mediators
class MediatorBadge {
  final String id;
  final String name;
  final String icon; // IconData name or asset path
  final String description;
  final DateTime earnedAt;

  const MediatorBadge({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.earnedAt,
  });

  factory MediatorBadge.fromJson(Map<String, dynamic> json) {
    return MediatorBadge(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      earnedAt: DateTime.parse(json['earnedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'description': description,
      'earnedAt': earnedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediatorBadge &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// BuyMediatorModel - Mediator/intermediary for secure transactions
///
/// Represents a trusted mediator who facilitates the transaction
class BuyMediatorModel {
  final String id;
  final String name;
  final String avatar;
  final double rating;
  final double programRating;
  final int transactionsCount;
  final String specialization;
  final List<PaymentMethodModel> paymentMethods;
  final String responseTime;
  final bool isOnline;
  final MediatorTier tier;
  final bool isVerified;
  final List<MediatorBadge> badges;
  final String bio;

  const BuyMediatorModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.rating,
    required this.programRating,
    required this.transactionsCount,
    required this.specialization,
    required this.paymentMethods,
    required this.responseTime,
    required this.tier,
    required this.badges,
    required this.bio,
    this.isOnline = true,
    this.isVerified = false,
  });

  factory BuyMediatorModel.fromJson(Map<String, dynamic> json) {
    return BuyMediatorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      rating: (json['rating'] as num).toDouble(),
      programRating: (json['programRating'] as num?)?.toDouble() ?? json['rating'] as double,
      transactionsCount: json['transactionsCount'] as int,
      specialization: json['specialization'] as String,
      paymentMethods: (json['paymentMethods'] as List)
          .map((e) => PaymentMethodModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      responseTime: json['responseTime'] as String,
      isOnline: json['isOnline'] as bool? ?? true,
      tier: json['tier'] != null
          ? MediatorTier.values.firstWhere(
              (e) => e.name == json['tier'],
              orElse: () => MediatorTier.bronze,
            )
          : MediatorTier.bronze,
      isVerified: json['isVerified'] as bool? ?? false,
      badges: (json['badges'] as List?)
              ?.map((e) => MediatorBadge.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      bio: json['bio'] as String? ?? '',
    );
  }

  /// Mock data
  static final List<BuyMediatorModel> mockMediators = [
    BuyMediatorModel(
      id: 'm1',
      name: 'Ahmed Mohamed',
      avatar: 'https://i.pravatar.cc/150?img=1',
      rating: 4.9,
      programRating: 4.8,
      transactionsCount: 1520,
      specialization: 'All Games',
      paymentMethods: [
        PaymentMethodModel(
          type: 'bank',
          name: 'Bank Transfer',
          icon: 'account_balance',
          details: 'Egyptian Banks',
        ),
        PaymentMethodModel(
          type: 'wallet',
          name: 'Vodafone Cash',
          icon: 'phone_iphone',
          details: '010xxxxxxx',
        ),
      ],
      responseTime: 'Usually responds in 5 min',
      isOnline: true,
      tier: MediatorTier.elite,
      isVerified: true,
      badges: [
        MediatorBadge(
          id: 'b1',
          name: 'Top Mediator',
          icon: 'emoji_events',
          description: 'Completed 1000+ successful transactions',
          earnedAt: DateTime(2024, 1, 15),
        ),
        MediatorBadge(
          id: 'b2',
          name: 'Fast Responder',
          icon: 'flash_on',
          description: 'Average response time under 5 minutes',
          earnedAt: DateTime(2024, 2, 1),
        ),
        MediatorBadge(
          id: 'b3',
          name: 'Trusted Partner',
          icon: 'verified',
          description: 'Member for over 2 years',
          earnedAt: DateTime(2024, 3, 10),
        ),
      ],
      bio: 'Professional game account mediator with 5+ years of experience. Specialized in FPS and MOBA games. 100% satisfaction rate.',
    ),
    BuyMediatorModel(
      id: 'm2',
      name: 'Sarah Ali',
      avatar: 'https://i.pravatar.cc/150?img=5',
      rating: 4.7,
      programRating: 4.6,
      transactionsCount: 892,
      specialization: 'FPS Games',
      paymentMethods: [
        PaymentMethodModel(
          type: 'wallet',
          name: 'InstaPay',
          icon: 'payment',
          details: '@username',
        ),
      ],
      responseTime: 'Usually responds in 10 min',
      isOnline: true,
      tier: MediatorTier.gold,
      isVerified: true,
      badges: [
        MediatorBadge(
          id: 'b4',
          name: 'Rising Star',
          icon: 'star',
          description: '500+ successful transactions',
          earnedAt: DateTime(2024, 1, 20),
        ),
      ],
      bio: 'Experienced mediator specializing in first-person shooter games. Quick and secure transactions guaranteed.',
    ),
    BuyMediatorModel(
      id: 'm3',
      name: 'Omar Hassan',
      avatar: 'https://i.pravatar.cc/150?img=3',
      rating: 4.5,
      programRating: 4.4,
      transactionsCount: 456,
      specialization: 'MOBA Games',
      paymentMethods: [
        PaymentMethodModel(
          type: 'bank',
          name: 'Bank Transfer',
          icon: 'account_balance',
          details: 'Egyptian Banks',
        ),
      ],
      responseTime: 'Usually responds in 15 min',
      isOnline: false,
      tier: MediatorTier.silver,
      isVerified: false,
      badges: [
        MediatorBadge(
          id: 'b5',
          name: 'Newcomer',
          icon: 'new_releases',
          description: 'Completed first 100 transactions',
          earnedAt: DateTime(2024, 2, 15),
        ),
      ],
      bio: 'Reliable mediator for MOBA games. Fast and professional service.',
    ),
    BuyMediatorModel(
      id: 'm4',
      name: 'Nour Ahmed',
      avatar: 'https://i.pravatar.cc/150?img=9',
      rating: 4.2,
      programRating: 4.1,
      transactionsCount: 125,
      specialization: 'Battle Royale',
      paymentMethods: [
        PaymentMethodModel(
          type: 'wallet',
          name: 'Vodafone Cash',
          icon: 'phone_iphone',
          details: '012xxxxxxx',
        ),
      ],
      responseTime: 'Usually responds in 20 min',
      isOnline: true,
      tier: MediatorTier.bronze,
      isVerified: false,
      badges: [],
      bio: 'Starting mediator specializing in Battle Royale games.',
    ),
  ];

  BuyMediatorModel copyWith({
    String? id,
    String? name,
    String? avatar,
    double? rating,
    double? programRating,
    int? transactionsCount,
    String? specialization,
    List<PaymentMethodModel>? paymentMethods,
    String? responseTime,
    bool? isOnline,
    MediatorTier? tier,
    bool? isVerified,
    List<MediatorBadge>? badges,
    String? bio,
  }) {
    return BuyMediatorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      rating: rating ?? this.rating,
      programRating: programRating ?? this.programRating,
      transactionsCount: transactionsCount ?? this.transactionsCount,
      specialization: specialization ?? this.specialization,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      responseTime: responseTime ?? this.responseTime,
      isOnline: isOnline ?? this.isOnline,
      tier: tier ?? this.tier,
      isVerified: isVerified ?? this.isVerified,
      badges: badges ?? this.badges,
      bio: bio ?? this.bio,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuyMediatorModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// PaymentMethodModel - Payment method details for mediator
class PaymentMethodModel {
  final String type; // bank, wallet, crypto
  final String name; // Bank Transfer, Vodafone Cash, etc.
  final String icon; // icon name
  final String details; // account number, phone number, etc.

  const PaymentMethodModel({
    required this.type,
    required this.name,
    required this.icon,
    required this.details,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      type: json['type'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      details: json['details'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethodModel &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          name == other.name;

  @override
  int get hashCode => type.hashCode ^ name.hashCode;
}
