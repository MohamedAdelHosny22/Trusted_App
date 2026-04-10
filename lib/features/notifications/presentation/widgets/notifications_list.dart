import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/models/notification_model.dart';
import 'notification_item.dart';

/// NotificationsList - List of notification items
///
/// Displays notifications in a scrollable list
class NotificationsList extends StatelessWidget {
  final List<NotificationModel> notifications;
  final Function(String) onNotificationTap;

  const NotificationsList({
    required this.notifications,
    required this.onNotificationTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.m,
      ),
      itemCount: notifications.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.s),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationItem(
          notification: notification,
          onTap: () => onNotificationTap(notification.id),
        );
      },
    );
  }
}
