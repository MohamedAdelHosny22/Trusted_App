import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';

/// PlaceholderChatScreen - Temporary placeholder for chat feature
///
/// TODO: Implement actual chat functionality
class PlaceholderChatScreen extends StatelessWidget {
  const PlaceholderChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.m),
            Text(
              'Messages',
              style: AppTextStyles.heading1,
            ),
            const SizedBox(height: AppSpacing.s),
            Text(
              'Chat feature coming soon',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
