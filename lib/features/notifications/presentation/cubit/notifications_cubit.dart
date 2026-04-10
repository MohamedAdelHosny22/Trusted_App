import 'package:flutter_bloc/flutter_bloc.dart';
import 'notifications_state.dart';
import '../../data/repositories/notifications_repository.dart';

/// NotificationsCubit - Business logic for notifications feature
///
/// Responsibilities:
/// - Load notifications from repository
/// - Mark notifications as read
/// - Manage loading and error states
class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository repository;

  NotificationsCubit({required this.repository})
      : super(const NotificationsState());

  /// Load notifications from repository
  Future<void> loadNotifications() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final notifications = await repository.getNotifications();
      emit(state.copyWith(
        notifications: notifications,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  /// Mark a notification as read
  void markAsRead(String notificationId) {
    final updatedNotifications = state.notifications.map((notification) {
      if (notification.id == notificationId) {
        return notification.copyWithRead();
      }
      return notification;
    }).toList();

    emit(state.copyWith(notifications: updatedNotifications));
  }

  /// Mark all notifications as read
  void markAllAsRead() {
    final updatedNotifications = state.notifications.map((notification) {
      return notification.copyWithRead();
    }).toList();

    emit(state.copyWith(notifications: updatedNotifications));
  }
}
