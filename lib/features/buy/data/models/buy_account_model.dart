import 'package:trusted_app/features/home/data/models/account_model.dart' as home;

/// BuyAccountModel - Game account available for purchase
///
/// Represents a game account listing with all relevant details
class BuyAccountModel {
  final String id;
  final String title;
  final String game;
  final String rank;
  final double price;
  final String seller;
  final String sellerAvatar;
  final double rating;
  final int reviewsCount;
  final String description;
  final List<String> images;
  final List<AccountFeatureModel> features;
  final bool isVerified;
  final bool isFeatured;

  const BuyAccountModel({
    required this.id,
    required this.title,
    required this.game,
    required this.rank,
    required this.price,
    required this.seller,
    required this.sellerAvatar,
    required this.rating,
    required this.reviewsCount,
    required this.description,
    required this.images,
    required this.features,
    this.isVerified = false,
    this.isFeatured = false,
  });

  factory BuyAccountModel.fromJson(Map<String, dynamic> json) {
    return BuyAccountModel(
      id: json['id'] as String,
      title: json['title'] as String,
      game: json['game'] as String,
      rank: json['rank'] as String,
      price: (json['price'] as num).toDouble(),
      seller: json['seller'] as String,
      sellerAvatar: json['sellerAvatar'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'] as int,
      description: json['description'] as String,
      images: List<String>.from(json['images'] as List),
      features: (json['features'] as List)
          .map((e) => AccountFeatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isVerified: json['isVerified'] as bool? ?? false,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }

  /// Mock data with real asset images
  static const List<BuyAccountModel> mockAccounts = [
    BuyAccountModel(
      id: '1',
      title: 'Lv. 72 Account',
      game: 'Valorant',
      rank: 'Radiant',
      price: 1299.0,
      seller: 'CyberTrader',
      sellerAvatar: '',
      rating: 4.9,
      reviewsCount: 127,
      description: 'Full access radiant account with all agents unlocked',
      images: [
        'assets/accounts/account_1.jpeg',
        'assets/accounts/account_2.jpeg',
        'assets/accounts/account_3.jpeg',
      ],
      features: [
        AccountFeatureModel(icon: 'stars', label: 'Radiant Rank'),
        AccountFeatureModel(icon: 'agents', label: 'All Agents'),
        AccountFeatureModel(icon: 'skins', label: '200+ Skins'),
      ],
      isVerified: true,
      isFeatured: true,
    ),
    BuyAccountModel(
      id: '2',
      title: 'Immortal Rank',
      game: 'Valorant',
      rank: 'Immortal',
      price: 899.0,
      seller: 'ProGamer',
      sellerAvatar: '',
      rating: 4.8,
      reviewsCount: 95,
      description: 'Immortal account with rare skins',
      images: [
        'assets/accounts/account_2.jpeg',
        'assets/accounts/account_4.jpeg',
        'assets/accounts/account_1.jpeg',
      ],
      features: [
        AccountFeatureModel(icon: 'rank', label: 'Immortal'),
        AccountFeatureModel(icon: 'skins', label: '150+ Skins'),
      ],
      isVerified: true,
      isFeatured: true,
    ),
    BuyAccountModel(
      id: '3',
      title: 'AR 55 Account',
      game: 'Genshin Impact',
      rank: 'AR 55',
      price: 299.0,
      seller: 'AnimeGamer',
      sellerAvatar: '',
      rating: 4.7,
      reviewsCount: 78,
      description: 'High AR account with 5-star characters',
      images: [
        'assets/accounts/account_3.jpeg',
        'assets/accounts/account_5.jpeg',
      ],
      features: [
        AccountFeatureModel(icon: 'rank', label: 'Adventure Rank 55'),
        AccountFeatureModel(icon: 'characters', label: '10x 5-Star'),
      ],
      isVerified: true,
      isFeatured: false,
    ),
    BuyAccountModel(
      id: '4',
      title: 'OG Cloud Trooper',
      game: 'Fortnite',
      rank: 'Level 150',
      price: 450.0,
      seller: 'FortNiteKing',
      sellerAvatar: '',
      rating: 4.6,
      reviewsCount: 156,
      description: 'OG account with rare skins',
      images: [
        'assets/accounts/account_4.jpeg',
        'assets/accounts/account_1.jpeg',
        'assets/accounts/account_3.jpeg',
        'assets/accounts/account_5.jpeg',
      ],
      features: [
        AccountFeatureModel(icon: 'rarity', label: 'OG Skins'),
        AccountFeatureModel(icon: 'level', label: 'Level 150'),
      ],
      isVerified: true,
      isFeatured: true,
    ),
    BuyAccountModel(
      id: '5',
      title: 'Diamond Account',
      game: 'Valorant',
      rank: 'Diamond',
      price: 199.0,
      seller: 'SkillBoost',
      sellerAvatar: '',
      rating: 4.5,
      reviewsCount: 62,
      description: 'Diamond ranked account ready to play',
      images: [
        'assets/accounts/account_5.jpeg',
      ],
      features: [
        AccountFeatureModel(icon: 'rank', label: 'Diamond'),
      ],
      isVerified: false,
      isFeatured: false,
    ),
    BuyAccountModel(
      id: '6',
      title: 'AR 45 Account',
      game: 'Genshin Impact',
      rank: 'AR 45',
      price: 149.0,
      seller: 'GachaMaster',
      sellerAvatar: '',
      rating: 4.4,
      reviewsCount: 43,
      description: 'Mid-game account with good progression',
      images: [
        'assets/accounts/account_1.jpeg',
        'assets/accounts/account_2.jpeg',
      ],
      features: [
        AccountFeatureModel(icon: 'rank', label: 'Adventure Rank 45'),
      ],
      isVerified: true,
      isFeatured: false,
    ),
    BuyAccountModel(
      id: '7',
      title: 'Platinum Elite',
      game: 'Valorant',
      rank: 'Platinum',
      price: 99.0,
      seller: 'RankUpPro',
      sellerAvatar: '',
      rating: 4.3,
      reviewsCount: 31,
      description: 'Platinum account with good agents',
      images: [
        'assets/accounts/account_3.jpeg',
        'assets/accounts/account_4.jpeg',
      ],
      features: [
        AccountFeatureModel(icon: 'rank', label: 'Platinum'),
      ],
      isVerified: false,
      isFeatured: false,
    ),
    BuyAccountModel(
      id: '8',
      title: 'Level 100 Battle Pass',
      game: 'Fortnite',
      rank: 'Level 100',
      price: 79.0,
      seller: 'BPGrinder',
      sellerAvatar: '',
      rating: 4.2,
      reviewsCount: 28,
      description: 'Max battle pass with exclusive skins',
      images: [
        'assets/accounts/account_2.jpeg',
        'assets/accounts/account_5.jpeg',
        'assets/accounts/account_1.jpeg',
      ],
      features: [
        AccountFeatureModel(icon: 'bp', label: 'Max BP'),
      ],
      isVerified: true,
      isFeatured: false,
    ),
  ];

  BuyAccountModel copyWith({
    String? id,
    String? title,
    String? game,
    String? rank,
    double? price,
    String? seller,
    String? sellerAvatar,
    double? rating,
    int? reviewsCount,
    String? description,
    List<String>? images,
    List<AccountFeatureModel>? features,
    bool? isVerified,
    bool? isFeatured,
  }) {
    return BuyAccountModel(
      id: id ?? this.id,
      title: title ?? this.title,
      game: game ?? this.game,
      rank: rank ?? this.rank,
      price: price ?? this.price,
      seller: seller ?? this.seller,
      sellerAvatar: sellerAvatar ?? this.sellerAvatar,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      description: description ?? this.description,
      images: images ?? this.images,
      features: features ?? this.features,
      isVerified: isVerified ?? this.isVerified,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuyAccountModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// AccountFeatureModel - Feature or highlight of an account
class AccountFeatureModel {
  final String icon;
  final String label;

  const AccountFeatureModel({
    required this.icon,
    required this.label,
  });

  factory AccountFeatureModel.fromJson(Map<String, dynamic> json) {
    return AccountFeatureModel(
      icon: json['icon'] as String,
      label: json['label'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountFeatureModel &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          label == other.label;

  @override
  int get hashCode => icon.hashCode ^ label.hashCode;
}

/// Extension to convert BuyAccountModel to home AccountModel
extension BuyAccountModelX on BuyAccountModel {
  /// Convert to home AccountModel for reuse in UI components
  home.AccountModel toHomeAccountModel() {
    return home.AccountModel(
      id: id,
      title: title,
      price: price,
      game: game,
      imageUrl: images.isNotEmpty ? images.first : '',
      categoryId: game, // Use game as category for now
      rating: rating,
      reviews: reviewsCount,
      isPremium: isFeatured,
      tier: isFeatured ? (price > 300 ? 'gold' : 'elite') : null,
    );
  }
}
