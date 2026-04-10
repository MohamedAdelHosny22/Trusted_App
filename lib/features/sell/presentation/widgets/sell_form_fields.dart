import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class SellFormFields extends StatelessWidget {
  final TextEditingController gameController;
  final TextEditingController priceController;
  final TextEditingController shortDescController;
  final TextEditingController fullDetailsController;

  const SellFormFields({
    super.key,
    required this.gameController,
    required this.priceController,
    required this.shortDescController,
    required this.fullDetailsController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Select Game
        _buildSectionTitle('Select Game'),
        _buildDropdown(
          label: 'Choose a game',
          controller: gameController,
        ),

        const SizedBox(height: AppSpacing.l),

        // Price
        _buildSectionTitle('Price'),
        _buildPriceInput(),

        const SizedBox(height: AppSpacing.l),

        // Short Description
        _buildSectionTitle('Short Description'),
        _buildTextarea(
          label: 'e.g. Rare skins & M416 Glacier Max',
          controller: shortDescController,
          minLines: 3,
        ),

        const SizedBox(height: AppSpacing.l),

        // Full Account Details
        _buildSectionTitle('Full Account Details'),
        _buildTextarea(
          label: 'List all your skins, ranks, items, and link methods...',
          controller: fullDetailsController,
          minLines: 5,
        ),

        const SizedBox(height: AppSpacing.l),

        // Account Photos
        _buildSectionTitle('Account Photos (Max 3)'),
        _buildPhotoUpload(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.m),
      child: Text(
        title,
        style: AppTextStyles.heading3.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.m + AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            label,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textSecondary,
          ),
          items: const [],
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget _buildPriceInput() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: AppTextStyles.bodyLarge,
              decoration: const InputDecoration(
                hintText: '0.00',
                hintStyle: TextStyle(
                  color: AppColors.textSecondary,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.m,
                  vertical: AppSpacing.m,
                ),
              ),
            ),
          ),
          // Currency Label
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.m),
            child: Text(
              'EGP',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextarea({
    required String label,
    required TextEditingController controller,
    required int minLines,
  }) {
    return TextField(
      controller: controller,
      maxLines: null,
      minLines: minLines,
      style: AppTextStyles.bodyLarge,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textTertiary,
          fontSize: 13,
        ),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(AppSpacing.m),
      ),
    );
  }

  Widget _buildPhotoUpload() {
    return Row(
      children: List.generate(
        3,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index < 2 ? AppSpacing.m : 0,
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.border,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.textTertiary,
                      size: 24,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Add Photo',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
