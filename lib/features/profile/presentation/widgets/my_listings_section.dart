import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/models/listing_model.dart';
import 'listing_card.dart';
import 'add_new_listing_card.dart';

/// MyListingsSection - User's listings section
///
/// Displays section header with horizontal scrollable listing cards
/// Figma Design: Node 2312:29
///
/// Design specifications:
/// - Section Title: "My Listings", heading3 style
/// - "View All" link: primary color, Medium weight
/// - Uses centralized AccountCard from core/widgets
class MyListingsSection extends StatelessWidget {
  final List<ListingModel> listings;
  final VoidCallback? onViewAll;
  final VoidCallback? onAddNew;
  final ValueChanged<ListingModel>? onListingTap;

  const MyListingsSection({
    super.key,
    required this.listings,
    this.onViewAll,
    this.onAddNew,
    this.onListingTap,
  });

  @override
  Widget build(BuildContext context) {
    if (listings.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 8),
        _buildListingCards(),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Listings',
            style: AppTextStyles.heading3,
          ),
          GestureDetector(
            onTap: onViewAll,
            child: Text(
              'View All',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListingCards() {
    return SizedBox(
      height: 220, // Proper height for the new design
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
        itemCount: listings.length + 1,
        separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.m),
        itemBuilder: (context, index) {
          if (index == 0) {
            return AddNewListingCard(onTap: onAddNew);
          }
          final listing = listings[index - 1];
          return SizedBox(
            width: 160,
            child: ClipRect(
              child: ListingCard(
                listing: listing,
                onTap: () => onListingTap?.call(listing),
                onViewDetails: () => onListingTap?.call(listing),
              ),
            ),
          );
        },
      ),
    );
  }
}
