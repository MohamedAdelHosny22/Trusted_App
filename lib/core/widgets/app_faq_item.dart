import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

/// AppFaqItem - Expandable FAQ item
///
/// Features:
/// - Rounded container
/// - Question text
/// - Expand/collapse animation
/// - Arrow icon rotation
class AppFaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const AppFaqItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<AppFaqItem> createState() => _AppFaqItemState();
}

class _AppFaqItemState extends State<AppFaqItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.m),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: AppShadows.xs,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          expansionTileTheme: ExpansionTileThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.m),
            ),
          ),
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(AppSpacing.m),
          childrenPadding: EdgeInsets.only(
            left: AppSpacing.m,
            right: AppSpacing.m,
            bottom: AppSpacing.m,
          ),
          iconColor: AppColors.primary,
          collapsedIconColor: AppColors.textSecondary,
          title: Text(
            widget.question,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: AnimatedRotation(
            duration: const Duration(milliseconds: 200),
            turns: _isExpanded ? 0.5 : 0,
            child: Icon(
              Icons.expand_more,
              color: _isExpanded
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.answer,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
