import 'package:trusted_app/features/home/data/models/account_model.dart' as home;
import 'package:trusted_app/features/buy/data/models/buy_account_model.dart';
import 'package:trusted_app/features/profile/data/models/listing_model.dart';

/// AccountCardData - Unified data model for account cards
///
/// This model represents all the data needed by [AccountCard] widget.
/// It provides a single interface that can be created from various
/// domain models (AccountModel, BuyAccountModel, ListingModel).
class AccountCardData {
  final String title;
  final String game;
  final double price;
  final String imageUrl;
  final double? rating;
  final int? reviewsCount;
  final String? tier;
  final bool isPremium;
  final bool isFeatured;
  final String id;

  const AccountCardData({
    required this.id,
    required this.title,
    required this.game,
    required this.price,
    required this.imageUrl,
    this.rating,
    this.reviewsCount,
    this.tier,
    this.isPremium = false,
    this.isFeatured = false,
  });
}

// ============================================================================
// EXTENSIONS: Convert domain models to AccountCardData
// ============================================================================

/// Extension on home.AccountModel
extension HomeAccountModelX on home.AccountModel {
  AccountCardData toAccountCardData() {
    return AccountCardData(
      id: id,
      title: title,
      game: game,
      price: price,
      imageUrl: imageUrl,
      rating: rating,
      reviewsCount: reviews,
      tier: tier,
      isPremium: isPremium,
      isFeatured: isPremium && tier != null,
    );
  }
}

/// Extension on BuyAccountModel
extension BuyAccountModelX on BuyAccountModel {
  AccountCardData toAccountCardData() {
    return AccountCardData(
      id: id,
      title: title,
      game: game,
      price: price,
      imageUrl: images.isNotEmpty ? images.first : '',
      rating: rating,
      reviewsCount: reviewsCount,
      tier: isFeatured ? (price > 300 ? 'gold' : 'elite') : null,
      isPremium: isFeatured,
      isFeatured: isFeatured,
    );
  }
}

/// Extension on ListingModel
extension ListingModelX on ListingModel {
  AccountCardData toAccountCardData() {
    return AccountCardData(
      id: id,
      title: title,
      game: game ?? 'Unknown',
      price: price,
      imageUrl: thumbnailUrl ?? '',
      tier: null,
      isPremium: false,
      isFeatured: false,
    );
  }
}
