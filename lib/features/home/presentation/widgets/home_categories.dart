import 'package:flutter/material.dart';
import 'package:trusted_app/features/home/data/models/category_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';
import '../cubit/home_cubit.dart';

class HomeCategories extends StatelessWidget {
  final List<CategoryModel> categories;
  final HomeCubit cubit;

  const HomeCategories({
    super.key,
    required this.categories,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
        ),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.s),
        itemBuilder: (context, index) {
          final category = categories[index];
          return _CategoryChip(
            category: category,
            isSelected: category.isSelected,
            onTap: () {
              cubit.filterByCategory(category.id);
            },
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: AppSpacing.s,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.chipRadius),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              category.icon,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              category.name,
              style: AppTextStyles.bodySmall.copyWith(
                color: isSelected ? AppColors.background : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
