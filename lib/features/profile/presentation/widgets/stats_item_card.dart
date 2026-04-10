import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';

/// StatsItemCard - Individual stat card for stats grid
///
/// Displays a single statistic with label, value, optional subtitle and icon
/// Figma Design: Node 2312:4, 2312:10, 2312:18, 2312:23
///
/// Design specifications:
/// - Background: cardSurface (40% opacity)
/// - Border: 1px, cardSurface color
/// - Border Radius: 12px (AppRadius.m)
/// - Padding: 16px (AppSpacing.m)
/// - Label: Uppercase, 10px, Bold, textTertiary color, 1.0 letter spacing
/// - Value: 24px, Black (900 weight), textBright color
/// - Subtitle: 14px, Medium (500 weight), primary color
/// - Icon: Star for rating, 16.67px size, primary color
class StatsItemCard extends StatelessWidget {
  final String label;
  final String value;
  final String? subtitle;
  final Widget? icon;

  const StatsItemCard({
    super.key,
    required this.label,
    required this.value,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.cardSurface.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppRadius.m),
        border: Border.all(
          color: AppColors.cardSurface,
          width: 1,
        ),
        boxShadow: AppShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Label - uppercase
          Text(
            label.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.labelUppercase,
          ),
          const SizedBox(height: 4), // Figma: itemSpacing 4px
          // Value and subtitle/icon row
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.statsNumber,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(width: AppSpacing.xs),
                Text(
                  subtitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.statsSubtitle,
                ),
              ],
              if (icon != null) ...[
                const SizedBox(width: AppSpacing.xs),
                icon!,
              ],
            ],
          ),
        ],
      ),
    );
  }
}
