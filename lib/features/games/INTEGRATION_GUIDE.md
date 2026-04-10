# Games Feature - Integration Guide

## Quick Start

The Games feature is already integrated with the home screen!

### How It Works

1. **From Home Screen**:
   - Scroll to "Popular Games" section
   - Tap "See All" button
   - Navigate to GamesScreen with all games in grid

2. **Games Screen**:
   - View all 12 games in responsive grid
   - Tap any game (currently logs to console)
   - Press back to return to home

## Manual Navigation

You can also navigate programmatically:

```dart
import 'package:trusted_app/features/games/presentation/screens/games_screen.dart';

// Navigate to games screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const GamesScreen(),
  ),
);
```

## Game Data

### Current Games (12 total)

1. PUBG
2. Free Fire
3. Call of Duty
4. Fortnite
5. Valorant
6. CoC (Clash of Clans)
7. Mobile Legends
8. Garena Free Fire
9. Clash Royale
10. Brawl Stars
11. PUBG Mobile
12. Call of Duty Mobile

### Adding More Games

Edit `games_remote_data_source.dart`:

```dart
return const [
  // ... existing games
  GameModel(
    id: '13',
    name: 'Your Game',
    icon: Icons.gamepad, // Choose appropriate icon
  ),
];
```

## Customization

### Change Grid Columns

Edit `games_grid.dart` column count logic:

```dart
if (constraints.maxWidth < 400) {
  crossAxisCount = 2; // Change to 3 for more columns
}
```

### Modify Game Icon Styling

The games reuse `AppCategoryItem` from core widgets:
- Circular icon container
- Border on selection
- Label below icon

To customize, modify `core/widgets/app_category_item.dart`.

### Adjust Spacing

In `games_grid.dart`:
```dart
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: crossAxisCount,
  childAspectRatio: 0.8,      // Adjust aspect ratio
  crossAxisSpacing: AppSpacing.m,  // Horizontal spacing
  mainAxisSpacing: AppSpacing.l,    // Vertical spacing
),
```

## Future Integration

### Game Details Screen

When ready, add navigation in `games_screen.dart`:

```dart
onGameTap: (game) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => GameDetailsScreen(gameId: game.id),
    ),
  );
},
```

### Filter Accounts by Game

```dart
// Navigate to filtered home screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => HomeScreen(
      filterGame: game.id, // Pass game filter
    ),
  ),
);
```

### Add go_router

If using go_router, add route:

```dart
GoRoute(
  path: '/games',
  builder: (context, state) => const GamesScreen(),
),
```

Then navigate with:
```dart
context.go('/games');
```

## Testing

### Test Responsiveness

The grid adapts to screen width:
- Small phones (< 400px): 2 columns
- Large phones (400-599px): 3 columns
- Tablets (>= 600px): 4 columns

Test on different screen sizes or use Flutter DevTools to resize.

### Test Navigation

1. Start app on home screen
2. Find "Popular Games" section
3. Tap "See All"
4. Verify games screen opens
5. Verify back button works

## Troubleshooting

### Games Not Loading

Check the cubit is initialized:
```dart
GamesCubit(repository: repository)..loadGames();
```

### Navigation Not Working

Verify import:
```dart
import 'package:trusted_app/features/games/presentation/screens/games_screen.dart';
```

### Grid Not Responsive

Ensure LayoutBuilder is used in games_grid.dart:
```dart
return LayoutBuilder(
  builder: (context, constraints) {
    // Calculate columns based on constraints.maxWidth
  },
);
```

## Support

For issues:
1. Check IMPLEMENTATION_SUMMARY.md for architecture
2. Review code comments in each file
3. Follow existing project patterns

## Next Steps

To enhance this feature:

1. **Add game images**: Replace icons with actual game logos
2. **Game details screen**: Show game info and related accounts
3. **Filter home screen**: Filter accounts by selected game
4. **Search**: Add search functionality
5. **Categories**: Group games by category
6. **Favorites**: Allow users to favorite games
