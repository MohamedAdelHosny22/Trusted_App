# Notifications Feature - Integration Guide

## How to Use

### 1. Import the Screen
```dart
import 'package:trusted_app/features/notifications/presentation/screens/notifications_screen.dart';
```

### 2. Navigate to Notifications
From any widget (e.g., HomeScreen notification bell):

```dart
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const NotificationsScreen(),
    ),
  );
}
```

Or using named routes (if configured):

```dart
Navigator.pushNamed(context, '/notifications');
```

### 3. Example: Connecting from HomeScreen

In `home_header.dart`:

```dart
Widget _buildNotificationButton() {
  return GestureDetector(
    onTap: () {
      // Navigate to notifications screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NotificationsScreen(),
        ),
      );
    },
    child: Container(
      // ... existing button code
      child: Stack(
        children: [
          // ... notification icon
          // Notification badge could show unread count here
        ],
      ),
    ),
  );
}
```

## Feature Highlights

### What's Included
✅ Beautiful, Figma-accurate UI
✅ Mock data with 7 sample notifications
✅ Different notification types with icons
✅ Read/unread states with visual distinction
✅ Empty state when no notifications
✅ Loading and error states
✅ Mark as read functionality
✅ Type-based color coding

### Notification Types
1. **Account Update** (cyan) - Profile changes, verifications
2. **Message** (purple) - New messages from users
3. **Security Alert** (yellow) - Login alerts, security notices
4. **Purchase** (green) - Transaction confirmations
5. **System** (gray) - Maintenance, updates

### UI Components
- **App Bar**: Clean back button + title
- **Notification Item**: Icon, title, description, time, unread dot
- **Empty State**: Friendly "all caught up" message
- **Loading Spinner**: Shows while fetching data
- **Error State**: Clear error message display

## Customization

### Modify Mock Data
Edit `notifications_remote_data_source.dart`:
```dart
return const [
  NotificationModel(
    id: '1',
    title: 'Your Title',
    description: 'Your description',
    time: '2h ago',
    isRead: false,
    type: NotificationType.accountUpdate,
  ),
  // Add more...
];
```

### Change Colors
Modify `notification_item.dart` icon colors:
```dart
case NotificationType.message:
  iconData = Icons.chat_bubble_outline;
  iconColor = AppColors.accentPurple; // Change this
  break;
```

### Adjust Styling
All styles use design system tokens:
- `AppTextStyles` - Typography
- `AppColors` - Colors
- `AppSpacing` - Spacing
- `AppRadius` - Border radius

## Future Enhancements

### API Integration
Replace mock data source with real API:
```dart
class NotificationsRemoteDataSource {
  Future<List<NotificationModel>> getNotifications() async {
    final response = await http.get(Uri.parse('/api/notifications'));
    // Parse and return...
  }
}
```

### Additional Features
- Pull-to-refresh
- Swipe to delete
- Mark all as read button
- Notification filtering by type
- Pagination for large lists
- Push notifications integration
- Deep linking to specific screens

## Testing

The feature is structured for easy testing:
- Repository pattern for data layer mocking
- Cubit for business logic testing
- Widget tests for UI components

Example test structure:
```dart
testWidgets('NotificationsScreen displays loading', (tester) async {
  await tester.pumpWidget(
    MaterialApp(home: NotificationsScreen()),
  );
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

## Support

For issues or questions:
1. Check IMPLEMENTATION_SUMMARY.md for architecture details
2. Review code comments in each file
3. Follow existing project patterns (similar to Home feature)
