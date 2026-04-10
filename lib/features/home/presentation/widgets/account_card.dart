import 'package:flutter/material.dart';
import 'package:trusted_app/features/home/data/models/account_model.dart';
import '../../../../core/widgets/account_card.dart' as core_widgets;

class AccountCard extends StatelessWidget {
  final AccountModel account;
  final String? sellerName;
  final String? sellerAvatar;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final VoidCallback? onViewDetails;
  final bool isFavorite;

  const AccountCard({
    super.key,
    required this.account,
    this.sellerName,
    this.sellerAvatar,
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
      imageUrl: account.imageUrl,
      sellerName: sellerName,
      sellerAvatar: sellerAvatar,
      onTap: onTap,
      onFavorite: onFavorite,
      onViewDetails: onViewDetails,
      isFavorite: isFavorite,
    );
  }
}
