import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// SwitchOptionItem - List item with toggle switch
///
/// Displays a security option with icon, title, description, and toggle switch
class SwitchOptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? description;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SwitchOptionItem({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardBorder,
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.m),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),

          const SizedBox(width: AppSpacing.m),

          // Title and Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge,
                ),
                if (description != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    description!,
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ],
            ),
          ),

          // Switch
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.border,
          ),
        ],
      ),
    );
  }
}
