import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/models/game_model.dart';
import 'game_item.dart';

/// GamesGrid - Responsive grid of game items
///
/// Displays games in a grid layout:
/// - 2 columns on small screens (< 400px)
/// - 3 columns on larger screens (>= 400px)
/// - 4 columns on tablets (>= 600px)
class GamesGrid extends StatelessWidget {
  final List<GameModel> games;
  final Function(GameModel) onGameTap;

  const GamesGrid({
    required this.games,
    required this.onGameTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine column count based on screen width
        int crossAxisCount;
        if (constraints.maxWidth < 400) {
          crossAxisCount = 2; // Small phones
        } else if (constraints.maxWidth < 600) {
          crossAxisCount = 3; // Large phones
        } else {
          crossAxisCount = 4; // Tablets
        }

        return GridView.builder(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.7,
            crossAxisSpacing: AppSpacing.m,
            mainAxisSpacing: AppSpacing.l,
          ),
          itemCount: games.length,
          itemBuilder: (context, index) {
            final game = games[index];
            return GameItem(
              game: game,
              onTap: () => onGameTap(game),
            );
          },
        );
      },
    );
  }
}
