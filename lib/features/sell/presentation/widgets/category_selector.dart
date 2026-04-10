import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class CategorySelector extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  static const List<String> _categories = [
    'Gaming Accounts',
    'In-Game Items',
    'Gift Cards',
    'Software',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          'Category',
          style: AppTextStyles.labelText,
        ),
        const SizedBox(height: AppSpacing.s),

        // Category Button
        GestureDetector(
          onTap: () => _showCategoryBottomSheet(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.m,
              vertical: AppSpacing.m + AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedCategory != null
                    ? AppColors.primary
                    : AppColors.border,
                width: selectedCategory != null ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.category_outlined,
                  color: selectedCategory != null
                      ? AppColors.primary
                      : AppColors.textTertiary,
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: Text(
                    selectedCategory ?? 'Select Category',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: selectedCategory != null
                          ? AppColors.textPrimary
                          : AppColors.textTertiary,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: selectedCategory != null
                      ? AppColors.primary
                      : AppColors.textTertiary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(
                top: AppSpacing.s,
                bottom: AppSpacing.m,
              ),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderSubtle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: Row(
                children: [
                  Text(
                    'Select Category',
                    style: AppTextStyles.heading3,
                  ),
                  const Spacer(),
                  IconButton(
                    // Navigator.pop is correct here for closing modal bottom sheet (not GoRouter)
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),

            // Categories List
            ListView.separated(
              shrinkWrap: true,
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: AppColors.borderSubtle,
                indent: AppSpacing.m,
              ),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = selectedCategory == category;

                return ListTile(
                  title: Text(
                    category,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                        )
                      : null,
                  onTap: () {
                    onCategorySelected(category);
                    // Navigator.pop is correct here for closing modal bottom sheet (not GoRouter)
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
