import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/chat_model.dart';

/// MessageBubble - Chat message bubble
class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.m),
      child: Row(
        mainAxisAlignment: isCurrentUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isCurrentUser) ...[
            _buildAvatar(),
            const SizedBox(width: AppSpacing.s),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!isCurrentUser) ...[
                  Text(
                    message.senderName,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.m,
                    vertical: AppSpacing.s,
                  ),
                  decoration: BoxDecoration(
                    color: isCurrentUser
                        ? AppColors.primary
                        : AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(AppRadius.m).copyWith(
                      topLeft: isCurrentUser ? const Radius.circular(12) : Radius.zero,
                      topRight: isCurrentUser ? Radius.zero : const Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    message.content,
                    style: AppTextStyles.body.copyWith(
                      color: isCurrentUser
                          ? AppColors.background
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(message.timestamp),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          if (isCurrentUser) ...[
            const SizedBox(width: AppSpacing.s),
            _buildAvatar(),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: ClipOval(
        child: message.senderAvatar.isNotEmpty
            ? Image.network(
                message.senderAvatar,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      message.senderName[0].toUpperCase(),
                      style: AppTextStyles.bodySmall,
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  message.senderName[0].toUpperCase(),
                  style: AppTextStyles.bodySmall,
                ),
              ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${time.day}/${time.month}';
    }
  }
}
