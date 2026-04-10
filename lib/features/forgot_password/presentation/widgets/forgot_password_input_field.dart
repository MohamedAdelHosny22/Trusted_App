import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/inputs.dart';

/// ForgotPasswordInputField - Styled text input field for forgot password
///
/// Wraps CustomInputField with forgot password-specific styling and spacing
/// Reusable for email field
class ForgotPasswordInputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const ForgotPasswordInputField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.enabled = true,
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
        enabled: enabled,
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
