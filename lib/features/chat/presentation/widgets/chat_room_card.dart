import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/chat_model.dart';

/// ChatRoomCard - Card for a chat room in the list
class ChatRoomCard extends StatelessWidget {
  final ChatRoom chat;
  final VoidCallback onTap;

  const ChatRoomCard({
    super.key,
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.s),
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.cardRadius),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            _buildAvatar(),

            const SizedBox(width: AppSpacing.m),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and unread badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.name,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (chat.unreadCount > 0) ...[
                        const SizedBox(width: AppSpacing.s),
                        _buildUnreadBadge(),
                      ],
                    ],
                  ),

                  const SizedBox(height: AppSpacing.xs),

                  // Last message and time
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage?.content ?? 'No messages yet',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s),
                      Text(
                        _formatTime(chat.lastMessageTime),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (chat.type == ChatType.group) {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.m),
        ),
        child: const Icon(
          Icons.group,
          color: AppColors.primary,
          size: 28,
        ),
      );
    } else {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: ClipOval(
          child: chat.avatar != null && chat.avatar!.isNotEmpty
              ? Image.network(
                  chat.avatar!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text(
                        chat.name[0].toUpperCase(),
                        style: AppTextStyles.bodyLarge,
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    chat.name[0].toUpperCase(),
                    style: AppTextStyles.bodyLarge,
                  ),
                ),
        ),
      );
    }
  }

  Widget _buildUnreadBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.badgeRadius),
      ),
      child: Text(
        chat.unreadCount > 9 ? '9+' : '${chat.unreadCount}',
        style: AppTextStyles.caption.copyWith(
          color: AppColors.background,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return '${time.day}/${time.month}';
    }
  }
}
