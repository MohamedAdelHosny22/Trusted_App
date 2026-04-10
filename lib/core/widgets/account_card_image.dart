import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import 'account_card_favorite_button.dart';

/// AccountCardImage - Image section for account cards
///
/// Displays the account image with optional overlay badges:
/// - Favorite button (top-right)
/// - Loading and error states
///
/// **Responsive Design:**
/// - Accepts optional height parameter (defaults to 100px for backward compatibility)
/// - When height is null, uses LayoutBuilder to calculate available space
/// - Maintains aspect ratio while fitting constraints
class AccountCardImage extends StatelessWidget {
  final String imageUrl;
  final Widget? badge;
  final VoidCallback? onFavorite;
  final bool isFavorite;
  final double? height; // Nullable for responsive calculation

  const AccountCardImage({
    super.key,
    required this.imageUrl,
    this.badge,
    this.onFavorite,
    this.isFavorite = false,
    this.height, // Optional: parent controls height
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main image
        _buildImage(),
        // Badge overlay (top-left) - not used anymore but kept for future
        if (badge != null)
          Positioned(
            top: AppSpacing.xs,
            left: AppSpacing.xs,
            child: badge!,
          ),
        // Favorite button overlay (top-right)
        if (onFavorite != null)
          Positioned(
            top: AppSpacing.xs,
            right: AppSpacing.xs,
            child: AccountCardFavoriteButton(
              isFavorite: isFavorite,
              onPressed: onFavorite,
            ),
          ),
      ],
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppRadius.cardRadius),
        topRight: Radius.circular(AppRadius.cardRadius),
      ),
      child: SizedBox(
        height: height ?? 100, // Use provided height or default 100px
        width: double.infinity,
        child: Container(
          color: AppColors.surface,
          child: imageUrl.isNotEmpty
              ? _buildImageWidget()
              : _buildPlaceholder(),
        ),
      ),
    );
  }

  /// Builds the appropriate image widget based on URL type
  /// - Assets (starts with 'assets/') → Image.asset
  /// - Network URLs → CachedNetworkImage
  Widget _buildImageWidget() {
    // Check if it's an asset path
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }

    // Otherwise use network image with caching
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => _buildPlaceholder(),
      placeholder: (context, url) => _buildLoadingPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.surface,
      child: Image.asset(
        'assets/images/26a8534fb2d7063e6157af9513b219d9.jpg',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.surface,
            child: const Icon(
              Icons.image_outlined,
              size: 40,
              color: AppColors.textSecondary,
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      color: AppColors.surface,
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ),
    );
  }
}
