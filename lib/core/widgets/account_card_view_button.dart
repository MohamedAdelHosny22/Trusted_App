import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// AccountCardViewButton - "View Details" button for account cards
///
/// Text button with hover effect for viewing account details
class AccountCardViewButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AccountCardViewButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xs),
        ),
      ),
      child: Text(
        'View Details',
        style: AppTextStyles.caption.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}
