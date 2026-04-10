import '../models/notification_model.dart';

/// NotificationsRemoteDataSource - Mock data source for notifications
///
/// Provides mock notification data for development
/// In production, this would fetch from an actual API
class NotificationsRemoteDataSource {
  const NotificationsRemoteDataSource();

  /// Fetch mock notifications
  Future<List<NotificationModel>> getNotifications() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      NotificationModel(
        id: '1',
        title: 'Account Verified',
        description: 'Your account has been successfully verified',
        time: '2h ago',
        isRead: false,
        type: NotificationType.accountUpdate,
      ),
      NotificationModel(
        id: '2',
        title: 'New Message',
        description: 'You have a new message from seller_123',
        time: '3h ago',
        isRead: false,
        type: NotificationType.message,
      ),
      NotificationModel(
        id: '3',
        title: 'Security Alert',
        description: 'New login detected from a new device',
        time: '5h ago',
        isRead: false,
        type: NotificationType.securityAlert,
      ),
      NotificationModel(
        id: '4',
        title: 'Purchase Successful',
        description: 'Your purchase of PUBG Account has been confirmed',
        time: '1d ago',
        isRead: true,
        type: NotificationType.purchase,
      ),
      NotificationModel(
        id: '5',
        title: 'Account Update',
        description: 'Your profile information has been updated',
        time: '2d ago',
        isRead: true,
        type: NotificationType.accountUpdate,
      ),
      NotificationModel(
        id: '6',
        title: 'System Maintenance',
        description: 'Scheduled maintenance will occur on Sunday 2 AM',
        time: '3d ago',
        isRead: true,
        type: NotificationType.system,
      ),
      NotificationModel(
        id: '7',
        title: 'New Message',
        description: 'You have a new message from support',
        time: '4d ago',
        isRead: true,
        type: NotificationType.message,
      ),
    ];
  }
}
