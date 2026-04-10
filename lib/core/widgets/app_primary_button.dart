import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import 'buttons.dart';

/// AppPrimaryButton - Reusable primary button for authentication screens
///
/// Wraps PrimaryButton with auth-specific defaults:
/// - Vertical padding: AppSpacing.m
/// - Full width
/// - Consistent styling across all auth screens
///
/// Usage:
/// ```dart
/// AppPrimaryButton(
///   text: 'Log In',
///   onPressed: _handleLogin,
///   isLoading: isLoading,
/// )
/// ```
class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AppPrimaryButton({
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
