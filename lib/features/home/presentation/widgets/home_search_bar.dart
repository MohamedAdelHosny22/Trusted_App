import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';
import '../cubit/home_cubit.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.s,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: TextField(
          style: AppTextStyles.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Search accounts...',
            hintStyle: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            prefixIcon: const Icon(
              Icons.search_outlined,
              color: AppColors.textSecondary,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.tune_outlined,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                // TODO: Open filter options
              },
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(AppSpacing.m),
          ),
          onChanged: (value) {
            cubit.searchAccounts(value);
          },
        ),
      ),
    );
  }
}
