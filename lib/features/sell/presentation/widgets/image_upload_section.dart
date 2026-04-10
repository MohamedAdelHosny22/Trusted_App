import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ImageUploadSection extends StatelessWidget {
  final List<String> images;
  final VoidCallback onMainImageTap;
  final VoidCallback onAddImageTap;
  final ValueChanged<int> onRemoveImage;

  const ImageUploadSection({
    super.key,
    required this.images,
    required this.onMainImageTap,
    required this.onAddImageTap,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Label
        Text(
          'Images',
          style: AppTextStyles.labelText,
        ),
        const SizedBox(height: AppSpacing.s),

        // Main Image Upload
        GestureDetector(
          onTap: onMainImageTap,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.border,
                width: 2,
              ),
            ),
            child: images.isNotEmpty
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(images[0]),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Remove Button
                      Positioned(
                        top: AppSpacing.s,
                        right: AppSpacing.s,
                        child: GestureDetector(
                          onTap: () => onRemoveImage(0),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.background.withValues(alpha: 0.8),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: AppColors.textPrimary,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      // Main Badge
                  Positioned(
                    bottom: AppSpacing.s,
                    left: AppSpacing.s,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'MAIN',
                        style: AppTextStyles.smallMediumText.copyWith(
                          color: AppColors.background,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : _buildUploadPlaceholder(
                icon: Icons.add_photo_alternate_outlined,
                label: 'Upload Main Image',
              ),
          ),
        ),
        const SizedBox(height: AppSpacing.m),

        // Additional Images
        if (images.isNotEmpty || images.length < 5)
          Text(
            'Additional Images (${images.isNotEmpty ? images.length - 1 : 0}/4)',
            style: AppTextStyles.labelText,
          ),
        if (images.isNotEmpty || images.length < 5)
          const SizedBox(height: AppSpacing.s),

        // Additional Images Row
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.isNotEmpty ? images.length - 1 : 0 + (images.length < 5 ? 1 : 0),
            separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.m),
            itemBuilder: (context, index) {
              // Add More Button
              if (images.length < 5 && index == (images.isNotEmpty ? images.length - 1 : 0)) {
                return GestureDetector(
                  onTap: onAddImageTap,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.borderSubtle,
                        width: 1,
                      ),
                    ),
                    child: _buildUploadPlaceholder(
                      icon: Icons.add,
                      label: 'Add',
                      isSmall: true,
                    ),
                  ),
                );
              }

              // Existing Additional Images
              final imageIndex = index + 1;
              if (imageIndex >= images.length) return const SizedBox.shrink();

              return GestureDetector(
                onTap: () => onRemoveImage(imageIndex),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.border,
                      width: 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: Image.file(
                          File(images[imageIndex]),
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Remove Button
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: AppColors.textPrimary,
                            size: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUploadPlaceholder({
    required IconData icon,
    required String label,
    bool isSmall = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: isSmall ? 28 : 40,
          color: AppColors.textTertiary,
        ),
        if (!isSmall) const SizedBox(height: AppSpacing.s),
        if (!isSmall)
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
      ],
    );
  }
}
