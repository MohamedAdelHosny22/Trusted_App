import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/account_card.dart' as core_widgets;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/listing_model.dart';

/// AllListingsScreen - Screen displaying all user listings in grid
///
/// Features:
/// - 2-column grid layout
/// - Back button
/// - Extended listings (12 items) from mockListingsExtended()
/// - Uses core AccountCard for consistency
class AllListingsScreen extends StatelessWidget {
  const AllListingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get extended listings directly (12 items)
    final extendedListings = ListingModel.mockListingsExtended();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'My Listings',
          style: AppTextStyles.heading2.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: extendedListings.isEmpty
          ? _buildEmptyState()
          : _buildListingsGrid(extendedListings),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.m),
          Text(
            'No listings yet',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            'Tap the + button to add your first listing',
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListingsGrid(List<ListingModel> listings) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.m),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.m,
          crossAxisSpacing: AppSpacing.m,
          childAspectRatio: 0.65, // More height for the card
        ),
        itemCount: listings.length,
        itemBuilder: (context, index) {
          final listing = listings[index];
          return ClipRect( // Prevent overflow
            child: core_widgets.AccountCard(
              title: listing.title,
              game: listing.game ?? 'Unknown', // Handle nullable game
              price: listing.price,
              imageUrl: listing.thumbnailUrl ?? 'https://via.placeholder.com/142x96', // Fallback URL
              sellerName: 'You', // Current user's listings
              onTap: () {
                // TODO: Navigate to listing details
              },
              onViewDetails: () {
                // TODO: Navigate to listing details
              },
            ),
          );
        },
      ),
    );
  }
}
