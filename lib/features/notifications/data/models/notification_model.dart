/// NotificationModel - Notification data model
///
/// Represents a single notification with all required properties
class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String time;
  final bool isRead;
  final NotificationType type;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.isRead = false,
    required this.type,
  });

  /// Mark notification as read
  NotificationModel copyWithRead() {
    return NotificationModel(
      id: id,
      title: title,
      description: description,
      time: time,
      isRead: true,
      type: type,
    );
  }
}

/// NotificationType - Type of notification for icon selection
enum NotificationType {
  accountUpdate,
  message,
  securityAlert,
  purchase,
  system,
}
