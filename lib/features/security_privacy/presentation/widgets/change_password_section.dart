import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// ChangePasswordSection - Section for changing password
///
/// Contains input fields for current and new password with validation
class ChangePasswordSection extends StatelessWidget {
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmNewPasswordController;
  final bool obscureCurrentPassword;
  final bool obscureNewPassword;
  final bool obscureConfirmPassword;
  final VoidCallback onToggleCurrentPassword;
  final VoidCallback onToggleNewPassword;
  final VoidCallback onToggleConfirmPassword;
  final VoidCallback onSubmit;
  final bool isLoading;

  const ChangePasswordSection({
    super.key,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmNewPasswordController,
    required this.obscureCurrentPassword,
    required this.obscureNewPassword,
    required this.obscureConfirmPassword,
    required this.onToggleCurrentPassword,
    required this.onToggleNewPassword,
    required this.onToggleConfirmPassword,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardBorder,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'Change Password',
            style: AppTextStyles.heading3,
          ),

          const SizedBox(height: AppSpacing.m),

          // Current Password Field
          _PasswordField(
            label: 'Current Password',
            controller: currentPasswordController,
            obscureText: obscureCurrentPassword,
            onToggle: onToggleCurrentPassword,
          ),

          const SizedBox(height: AppSpacing.m),

          // New Password Field
          _PasswordField(
            label: 'New Password',
            controller: newPasswordController,
            obscureText: obscureNewPassword,
            onToggle: onToggleNewPassword,
          ),

          const SizedBox(height: AppSpacing.m),

          // Confirm New Password Field
          _PasswordField(
            label: 'Confirm New Password',
            controller: confirmNewPasswordController,
            obscureText: obscureConfirmPassword,
            onToggle: onToggleConfirmPassword,
          ),

          const SizedBox(height: AppSpacing.l),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.m,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.background,
                        ),
                      ),
                    )
                  : Text(
                      'Change Password',
                      style: AppTextStyles.buttonText.copyWith(
                        color: AppColors.background,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

/// _PasswordField - Password input field with toggle visibility
class _PasswordField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.label,
    required this.controller,
    required this.obscureText,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: AppTextStyles.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.labelText,
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        suffixIcon: GestureDetector(
          onTap: onToggle,
          child: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.textSecondary,
            size: AppSpacing.iconSizeSmall,
          ),
        ),
      ),
    );
  }
}
