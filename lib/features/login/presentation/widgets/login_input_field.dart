import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/inputs.dart';

/// LoginInputField - Styled text input field for login
///
/// Wraps CustomInputField with login-specific styling and spacing
/// Reusable for username and password fields
class LoginInputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const LoginInputField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
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
        obscureText: obscureText,
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
