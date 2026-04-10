import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

/// AppSearchBar - Reusable search bar component
///
/// Features:
/// - Rounded container with surface color
/// - Search icon prefix
/// - Optional filter icon suffix
/// - Customizable placeholder text
class AppSearchBar extends StatelessWidget {
  final String placeholder;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final TextEditingController? controller;

  const AppSearchBar({
    super.key,
    this.placeholder = 'Search accounts, games, price...',
    this.onChanged,
    this.onFilterTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.inputRadius),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: AppShadows.xs,
      ),
      child: TextField(
        controller: controller,
        style: AppTextStyles.bodyLarge,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
          prefixIcon: Icon(
            Icons.search_outlined,
            color: AppColors.textSecondary,
            size: AppSpacing.iconSize,
          ),
          suffixIcon: onFilterTap != null
              ? IconButton(
                  icon: Icon(
                    Icons.tune_outlined,
                    color: AppColors.textSecondary,
                    size: AppSpacing.iconSize,
                  ),
                  onPressed: onFilterTap,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(AppSpacing.inputPadding),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
