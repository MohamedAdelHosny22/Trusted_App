import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/data_sources/notifications_remote_data_source.dart';
import '../../data/repositories/notifications_repository_impl.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';
import '../widgets/widgets.dart';

/// NotificationsScreen - Screen displaying user notifications
///
/// Features:
/// - App bar with back button and title
/// - List of notifications
/// - Empty state when no notifications
/// - Mark as read functionality
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _createNotificationsCubit(),
      child: const _NotificationsContent(),
    );
  }

  NotificationsCubit _createNotificationsCubit() {
    final repository = NotificationsRepositoryImpl(
      remoteDataSource: const NotificationsRemoteDataSource(),
    );
    return NotificationsCubit(repository: repository)..loadNotifications();
  }
}

class _NotificationsContent extends StatefulWidget {
  const _NotificationsContent();

  @override
  State<_NotificationsContent> createState() => _NotificationsContentState();
}

class _NotificationsContentState extends State<_NotificationsContent> {
  @override
  void initState() {
    super.initState();
    // Load notifications when screen initializes
    context.read<NotificationsCubit>().loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: AppSpacing.m),
                  Text(
                    'Error loading notifications',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.s),
                  Text(
                    state.error!,
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state.notifications.isEmpty) {
            return const NotificationsEmptyState();
          }

          return NotificationsList(
            notifications: state.notifications,
            onNotificationTap: (notificationId) {
              context
                  .read<NotificationsCubit>()
                  .markAsRead(notificationId);
            },
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.textPrimary,
        ),
        onPressed: () => context.pop(),
      ),
      title: Text(
        'Notifications',
        style: AppTextStyles.heading2,
      ),
      centerTitle: true,
    );
  }
}
