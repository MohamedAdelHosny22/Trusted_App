import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';

/// LoginButton - Primary call-to-action button for login
///
/// Wraps PrimaryButton with login-specific styling and spacing
/// Handles loading state and full-width display
class LoginButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const LoginButton({
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
