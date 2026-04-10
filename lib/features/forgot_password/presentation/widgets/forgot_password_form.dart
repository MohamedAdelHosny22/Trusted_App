import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_text_field.dart';

/// ForgotPasswordForm - Password reset form with email field
///
/// Features:
/// - Email input with validation
/// - Submit button with loading state
class ForgotPasswordForm extends StatelessWidget {
  final TextEditingController emailController;
  final bool isLoading;
  final VoidCallback onSendResetLink;

  const ForgotPasswordForm({
    super.key,
    required this.emailController,
    required this.isLoading,
    required this.onSendResetLink,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'Email',
          hint: 'Enter your email',
          controller: emailController,
          enabled: !isLoading,
          prefixIcon: const Icon(
            Icons.email_outlined,
            size: 16,
            color: AppColors.textSecondary,
          ),
        ),

        AppPrimaryButton(
          text: 'Send Reset Link',
          onPressed: onSendResetLink,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
