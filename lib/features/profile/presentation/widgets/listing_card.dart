import 'package:flutter/material.dart';
import '../../../../core/widgets/account_card.dart' as core_widgets;
import '../../data/models/listing_model.dart';

/// ListingCard - Profile feature wrapper for core AccountCard
///
/// This widget provides a unified interface for displaying user's listings
/// using the core [AccountCard] widget.
///
/// **Note:** This is just a thin wrapper. The actual implementation
/// is in [lib/core/widgets/account_card.dart].
///
/// **Usage:**
/// ```dart
/// ListingCard(
///   listing: myListingModel,
///   onTap: () => navigateToDetails(),
/// )
/// ```
class ListingCard extends StatelessWidget {
  final ListingModel listing;
  final VoidCallback? onTap;
  final VoidCallback? onViewDetails;

  const ListingCard({
    super.key,
    required this.listing,
    this.onTap,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return core_widgets.AccountCard(
      title: listing.title,
      game: listing.game ?? 'Unknown',
      price: listing.price,
      imageUrl: listing.thumbnailUrl ?? '',
      sellerName: 'You', // Current user's listings
      onTap: onTap,
      onViewDetails: onViewDetails,
    );
  }
}
