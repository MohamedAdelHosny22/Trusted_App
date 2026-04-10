import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/game_model.dart';

/// GameItem - Single game card widget
///
/// Displays:
/// - Rounded square container with icon
/// - Game name below (centered)
class GameItem extends StatelessWidget {
  final GameModel game;
  final VoidCallback onTap;

  const GameItem({
    required this.game,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Game icon/image container (fixed aspect ratio)
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.m),
                border: Border.all(
                  color: AppColors.border,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.m),
                child: _buildContent(),
              ),
            ),
          ),
          // Spacing between image and text
          const SizedBox(height: AppSpacing.s),
          // Game name
          SizedBox(
            width: double.infinity,
            child: Text(
              game.name,
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    // Handle both image and icon in the exact same container
    if (game.imageUrl != null) {
      // Check if it's an asset path or network URL
      if (game.imageUrl!.startsWith('assets/')) {
        return Image.asset(
          game.imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                game.icon,
                size: 32,
                color: AppColors.textSecondary,
              ),
            );
          },
        );
      } else {
        return Image.network(
          game.imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                game.icon,
                size: 32,
                color: AppColors.textSecondary,
              ),
            );
          },
        );
      }
    }

    // No image - show centered icon
    return Center(
      child: Icon(
        game.icon,
        size: 32,
        color: AppColors.textSecondary,
      ),
    );
  }
}
