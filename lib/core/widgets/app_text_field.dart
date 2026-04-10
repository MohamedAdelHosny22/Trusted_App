import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import 'inputs.dart';

/// AppTextField - Reusable text input field for authentication screens
///
/// Wraps CustomInputField with auth-specific defaults:
/// - Bottom margin: AppSpacing.m
/// - Full width
/// - Consistent styling across all auth screens
///
/// Usage:
/// ```dart
/// AppTextField(
///   label: 'Email',
///   hint: 'Enter your email',
///   controller: _controller,
///   prefixIcon: Icon(Icons.email),
/// )
/// ```
class AppTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final bool enabled;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.m),
      child: CustomInputField(
        label: label,
        hint: hint,
        controller: controller,
        obscureText: obscureText,
        enabled: enabled,
        keyboardType: keyboardType ?? TextInputType.text,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.m,
                  right: AppSpacing.s,
                ),
                child: prefixIcon,
              )
            : null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
