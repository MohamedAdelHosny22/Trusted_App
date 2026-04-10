import '../models/notification_model.dart';
import '../data_sources/notifications_remote_data_source.dart';
import 'notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource remoteDataSource;

  const NotificationsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<NotificationModel>> getNotifications() async {
    return await remoteDataSource.getNotifications();
  }
}
