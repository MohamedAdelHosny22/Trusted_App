import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import 'account_card_content.dart';
import 'account_card_image.dart';

/// AccountCard - Unified reusable card for marketplace items
///
/// **ONE design used everywhere:**
/// - Home feature (featured accounts, popular accounts)
/// - Profile feature (my listings)
/// - Buy feature (buy accounts)
/// - Search results
///
/// **Architecture:**
/// - Composed of modular widgets for SRP
/// - No hardcoded values (uses design tokens)
/// - Fully reusable across all features
/// - **Fixed image height (85px)** to prevent overflow
///
/// **Features:**
/// - Image with optional favorite button
/// - Game name (directly under image)
/// - Account title (single line + ellipsis)
/// - Price
/// - Seller info (avatar + username) at bottom
/// - View Details button
/// - Tap gesture for navigation
///
/// **Usage:**
/// ```dart
/// AccountCard(
///   title: 'Radiant Account',
///   game: 'Valorant',
///   price: 1299.0,
///   imageUrl: 'https://...',
///   sellerName: 'CyberTrader',
///   sellerAvatar: 'https://...',
///   onTap: () => navigateToDetails(),
///   onFavorite: () => toggleFavorite(),
///   isFavorite: false,
/// )
/// ```
class AccountCard extends StatelessWidget {
  // Core data
  final String title;
  final String game;
  final double price;
  final String imageUrl;

  // Optional data
  final String? sellerName;
  final String? sellerAvatar;

  // Actions
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final VoidCallback? onViewDetails;
  final bool isFavorite;

  const AccountCard({
    super.key,
    required this.title,
    required this.game,
    required this.price,
    required this.imageUrl,
    this.sellerName,
    this.sellerAvatar,
    this.onTap,
    this.onFavorite,
    this.onViewDetails,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.cardRadius),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section with favorite button (flexible - takes available space)
            Flexible(
              flex: 3, // Image takes 3 parts of space
              fit: FlexFit.tight,
              child: _buildImageSection(),
            ),
            // Content section (fixed size based on content)
            AccountCardContent(
              title: title,
              game: game,
              price: price,
              sellerName: sellerName,
              sellerAvatar: sellerAvatar,
              onViewDetails: onViewDetails,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return AccountCardImage(
      imageUrl: imageUrl,
      badge: null, // No badges
      onFavorite: onFavorite,
      isFavorite: isFavorite,
      height: double.infinity, // Takes all available space from Flexible
    );
  }
}
