import 'package:trusted_app/features/notifications/data/models/notification_model.dart';

/// NotificationsState - State for notifications feature
///
/// Manages the list of notifications and loading state
class NotificationsState {
  final List<NotificationModel> notifications;
  final bool isLoading;
  final String? error;

  const NotificationsState({
    this.notifications = const [],
    this.isLoading = false,
    this.error,
  });

  NotificationsState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
    String? error,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  /// Get unread notifications count
  int get unreadCount => notifications.where((n) => !n.isRead).length;
}
