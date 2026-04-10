import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// AppAvatar - Reusable avatar component
///
/// Displays user profile image with optional border and placeholder
/// Sizes: small (32px), medium (48px), large (64px), xlarge (80px)
class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? username;
  final AppAvatarSize size;
  final double? borderWidth;
  final Color? borderColor;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.username,
    this.size = AppAvatarSize.medium,
    this.borderWidth,
    this.borderColor,
  });

  double get _dimension {
    switch (size) {
      case AppAvatarSize.small:
        return 32.0;
      case AppAvatarSize.medium:
        return 48.0;
      case AppAvatarSize.large:
        return 64.0;
      case AppAvatarSize.xlarge:
        return 80.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // DEBUG MODE - Make layout VISIBLE
    const bool debug = true;

    final finalBorderWidth = borderWidth ?? 2.0;
    final finalBorderColor = borderColor ?? AppColors.primary;

    if (debug) {
      // DEBUG: Show ACTUAL layout with visible colors
      return Container(
        width: _dimension,
        height: _dimension,
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.3), // DEBUG: Red background
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.yellow, // DEBUG: Yellow border
            width: 3, // DEBUG: Thicker border to see it
          ),
        ),
        child: ClipOval(
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  width: _dimension,
                  height: _dimension,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholder();
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return _buildLoadingIndicator();
                  },
                )
              : _buildPlaceholder(),
        ),
      );
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      width: _dimension,
      height: _dimension,
      color: AppColors.surface,
      child: Center(
        child: Icon(
          Icons.person,
          size: _dimension * 0.5,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      width: _dimension,
      height: _dimension,
      color: AppColors.surface,
      child: Center(
        child: SizedBox(
          width: _dimension * 0.3,
          height: _dimension * 0.3,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ),
    );
  }
}

/// Avatar size options
enum AppAvatarSize {
  small,
  medium,
  large,
  xlarge,
}
