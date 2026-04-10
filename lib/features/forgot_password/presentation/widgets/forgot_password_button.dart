import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';

/// ForgotPasswordButton - Primary call-to-action button for forgot password
///
/// Wraps PrimaryButton with forgot password-specific styling and spacing
/// Handles loading state and full-width display
class ForgotPasswordButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const ForgotPasswordButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.m),
      child: PrimaryButton(
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        isFullWidth: true,
      ),
    );
  }
}
