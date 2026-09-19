import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../buy/data/models/buy_mediator_model.dart';
import '../widgets/mediator_selector_card.dart';
import '../cubit/sell_listing_cubit.dart';
import '../cubit/sell_listing_state.dart';
import 'preview_listing_screen.dart';

/// SellListingScreen - List your account for sale
///
/// Features:
/// - App bar with back button
/// - Warning message
/// - Game selection dropdown
/// - Price input
/// - Short description (limited)
/// - Full details (limited but more space)
/// - Image upload (up to 3 images)
/// - Mediator selection (minimum 3)
/// - Trust message
/// - Preview Listing button
class SellListingScreen extends StatefulWidget {
  const SellListingScreen({super.key});

  @override
  State<SellListingScreen> createState() => _SellListingScreenState();
}

class _SellListingScreenState extends State<SellListingScreen> {
  late final SellListingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = SellListingCubit();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: const _SellListingContent(),
    );
  }
}

class _SellListingContent extends StatefulWidget {
  const _SellListingContent();

  @override
  State<_SellListingContent> createState() => _SellListingContentState();
}

class _SellListingContentState extends State<_SellListingContent> {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.l),

            // Warning message
            _buildWarningMessage(),

            const SizedBox(height: AppSpacing.l),

            // Form fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: BlocBuilder<SellListingCubit, SellListingState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Game selection
                      _buildSectionTitle('Game'),
                      const SizedBox(height: AppSpacing.s),
                      _buildGameDropdown(context, state),

                      const SizedBox(height: AppSpacing.l),

                      // Price
                      _buildSectionTitle('Price (USD)'),
                      const SizedBox(height: AppSpacing.s),
                      _buildPriceInput(context, state),

                      const SizedBox(height: AppSpacing.l),

                      // Short description
                      _buildSectionTitle('Short Description'),
                      _buildSectionSubtitle('Max 100 characters'),
                      const SizedBox(height: AppSpacing.s),
                      _buildShortDescriptionInput(context, state),

                      const SizedBox(height: AppSpacing.l),

                      // Full details
                      _buildSectionTitle('Full Details'),
                      _buildSectionSubtitle('Max 500 characters'),
                      const SizedBox(height: AppSpacing.s),
                      _buildFullDetailsInput(context, state),

                      const SizedBox(height: AppSpacing.l),

                      // Image upload
                      _buildSectionTitle('Account Screenshots'),
                      _buildSectionSubtitle('Upload up to 3 images'),
                      const SizedBox(height: AppSpacing.s),
                      _buildImageUpload(context, state),

                      const SizedBox(height: AppSpacing.l),

                      // Mediator selection
                      _buildSectionTitle('Select Mediators'),
                      _buildSectionSubtitle('Choose at least 3 mediators'),
                      const SizedBox(height: AppSpacing.s),
                      _buildMediatorSelection(context, state),

                      const SizedBox(height: AppSpacing.xl),

                      // Trust message
                      _buildTrustMessage(),

                      const SizedBox(height: AppSpacing.xl),

                      // Preview button
                      _buildPreviewButton(context, state),

                      const SizedBox(height: AppSpacing.xxl),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.textPrimary,
        ),
        // Go back to mediator dashboard
        onPressed: () => context.go('/mediator?tab=0'),
      ),
      centerTitle: true,
      title: Text(
        'List Your Account',
        style: AppTextStyles.heading3,
      ),
    );
  }

  Widget _buildWarningMessage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: AppColors.warning,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Text(
              'Make sure to provide accurate information. False listings may result in account suspension.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.warning,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.bodyLarge.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSectionSubtitle(String title) {
    return Text(
      title,
      style: AppTextStyles.bodySmall.copyWith(
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildGameDropdown(BuildContext context, SellListingState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.inputRadius),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: state.selectedGame,
          isExpanded: true,
          hint: Text(
            'Select a game',
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textSecondary,
          ),
          items: const [
            'PUBG Mobile',
            'Free Fire',
            'Call of Duty Mobile',
            'Fortnite',
            'Mobile Legends',
            'Garena Free Fire MAX',
          ].map((String game) {
            return DropdownMenuItem<String>(
              value: game,
              child: Text(
                game,
                style: AppTextStyles.body,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              context.read<SellListingCubit>().updateGame(value);
            }
          },
        ),
      ),
    );
  }

  Widget _buildPriceInput(BuildContext context, SellListingState state) {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: AppTextStyles.body,
      decoration: InputDecoration(
        hintText: 'Enter price in USD',
        hintStyle: AppTextStyles.body.copyWith(
          color: AppColors.textSecondary,
        ),
        prefixIcon: const Icon(
          Icons.attach_money,
          color: AppColors.textSecondary,
        ),
        fillColor: AppColors.surface,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        contentPadding: const EdgeInsets.all(AppSpacing.m),
      ),
      onChanged: (value) {
        context.read<SellListingCubit>().updatePrice(value);
      },
    );
  }

  Widget _buildShortDescriptionInput(BuildContext context, SellListingState state) {
    return TextField(
      maxLength: 100,
      maxLines: 2,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        hintText: 'Brief description of your account...',
        hintStyle: AppTextStyles.body.copyWith(
          color: AppColors.textSecondary,
        ),
        fillColor: AppColors.surface,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.all(AppSpacing.m),
        counterText: '${state.shortDescription.length}/100',
      ),
      onChanged: (value) {
        context.read<SellListingCubit>().updateShortDescription(value);
      },
    );
  }

  Widget _buildFullDetailsInput(BuildContext context, SellListingState state) {
    return TextField(
      maxLength: 500,
      maxLines: 6,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        hintText: 'Full details including rank, skins, achievements, etc...',
        hintStyle: AppTextStyles.body.copyWith(
          color: AppColors.textSecondary,
        ),
        fillColor: AppColors.surface,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.all(AppSpacing.m),
        counterText: '${state.fullDetails.length}/500',
      ),
      onChanged: (value) {
        context.read<SellListingCubit>().updateFullDetails(value);
      },
    );
  }

  Widget _buildImageUpload(BuildContext context, SellListingState state) {
    return Column(
      children: [
        Row(
          children: [
            // Uploaded images
            ...List.generate(state.images.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.m),
                child: _buildImageThumbnail(state.images[index], index),
              );
            }),

            // Upload button (if less than 3 images)
            if (state.images.length < 3)
              _buildUploadButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildImageThumbnail(String imagePath, int index) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.m),
            border: Border.all(
              color: AppColors.border,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.m),
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              context.read<SellListingCubit>().removeImage(index);
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: AppColors.background,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.m),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_photo_alternate_outlined,
              color: AppColors.textSecondary,
              size: 32,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Upload',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediatorSelection(BuildContext context, SellListingState state) {
    return Column(
      children: BuyMediatorModel.mockMediators.map((mediator) {
        final isSelected = state.selectedMediators.contains(mediator.id);
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.m),
          child: MediatorSelectorCard(
            mediator: mediator,
            isSelected: isSelected,
            onTap: () {
              context.read<SellListingCubit>().toggleMediator(mediator.id);
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTrustMessage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(
          color: AppColors.success.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.verified_user_rounded,
            color: AppColors.success,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Text(
              'Your listing will be reviewed by our team. Mediators will verify your account details before listing.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.success,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewButton(BuildContext context, SellListingState state) {
    final isValid = state.isValid;
    final selectedMediatorsCount = state.selectedMediators.length;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isValid && selectedMediatorsCount >= 3
            ? () => _handlePreview(context)
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isValid && selectedMediatorsCount >= 3
              ? AppColors.primary
              : AppColors.disabledBackground,
          foregroundColor: AppColors.background,
          disabledBackgroundColor: AppColors.disabledBackground,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.m,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
          ),
        ),
        child: Column(
          children: [
            Text(
              'Preview Listing',
              style: AppTextStyles.buttonText.copyWith(
                color: isValid && selectedMediatorsCount >= 3
                    ? AppColors.background
                    : AppColors.textSecondary,
              ),
            ),
            if (selectedMediatorsCount < 3) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Select at least 3 mediators ($selectedMediatorsCount/3 selected)',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.error,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null && context.mounted) {
        context.read<SellListingCubit>().addImage(image.path);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _handlePreview(BuildContext context) {
    final state = context.read<SellListingCubit>().state;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PreviewListingScreen(
          listingData: state.toMap(),
        ),
      ),
    );
  }
}
