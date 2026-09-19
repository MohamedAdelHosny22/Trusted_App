import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// ApprovalActionsWidget - Approve/Reject buttons
///
/// Shows action buttons for pending payment requests
class ApprovalActionsWidget extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onApprove;
  final Function(String) onReject;

  const ApprovalActionsWidget({
    super.key,
    required this.isLoading,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Approve button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : onApprove,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: AppColors.background,
              disabledBackgroundColor: AppColors.disabledBackground,
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.m,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.background,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.s),
                      Text(
                        'Approve Payment',
                        style: AppTextStyles.buttonText.copyWith(
                          color: AppColors.background,
                        ),
                      ),
                    ],
                  ),
          ),
        ),

        const SizedBox(height: AppSpacing.m),

        // Reject button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: isLoading
                ? null
                : () => _showRejectDialog(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: BorderSide(
                color: isLoading
                    ? AppColors.disabledBackground
                    : AppColors.error,
                width: 1.5,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.m,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cancel,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.s),
                Text(
                  'Reject Payment',
                  style: AppTextStyles.buttonText.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showRejectDialog(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        ),
        title: Text(
          'Reject Payment',
          style: AppTextStyles.heading3,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please provide a reason for rejection',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.m),
            TextField(
              controller: reasonController,
              maxLines: 3,
              style: AppTextStyles.body,
              decoration: InputDecoration(
                hintText: 'Enter rejection reason...',
                hintStyle: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.s),
                  borderSide: BorderSide(
                    color: AppColors.border,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.s),
                  borderSide: BorderSide(
                    color: AppColors.border,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.s),
                  borderSide: BorderSide(
                    color: AppColors.error,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.buttonText.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final reason = reasonController.text.trim();
              if (reason.isNotEmpty) {
                Navigator.pop(context);
                onReject(reason);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Please enter a rejection reason',
                      style: AppTextStyles.body,
                    ),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.background,
            ),
            child: Text(
              'Reject',
              style: AppTextStyles.buttonText.copyWith(
                color: AppColors.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
