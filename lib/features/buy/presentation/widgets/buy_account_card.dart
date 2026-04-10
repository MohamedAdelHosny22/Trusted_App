import 'package:flutter/material.dart';
import '../../../../core/widgets/account_card.dart' as core_widgets;
import '../../data/models/buy_account_model.dart';

/// BuyAccountCard - Buy feature wrapper for core AccountCard
///
/// This widget provides a unified interface for displaying accounts
/// available for purchase using the core [AccountCard] widget.
///
/// **Note:** This is just a thin wrapper. The actual implementation
/// is in [lib/core/widgets/account_card.dart].
///
/// **Usage:**
/// ```dart
/// BuyAccountCard(
///   account: myBuyAccountModel,
///   onTap: () => navigateToDetails(),
///   onFavorite: () => toggleFavorite(),
///   isFavorite: false,
/// )
/// ```
class BuyAccountCard extends StatelessWidget {
  final BuyAccountModel account;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final VoidCallback? onViewDetails;
  final bool isFavorite;

  const BuyAccountCard({
    super.key,
    required this.account,
    this.onTap,
    this.onFavorite,
    this.onViewDetails,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return core_widgets.AccountCard(
      title: account.title,
      game: account.game,
      price: account.price,
      imageUrl: account.images.isNotEmpty ? account.images.first : '',
      sellerName: account.seller,
      sellerAvatar: account.sellerAvatar,
      onTap: onTap,
      onFavorite: onFavorite,
      onViewDetails: onViewDetails ?? onTap,
      isFavorite: isFavorite,
    );
  }
}
