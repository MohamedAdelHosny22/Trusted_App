import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/inputs.dart';

/// SignupInputField - Styled text input field for signup
///
/// Wraps CustomInputField with signup-specific styling and spacing
/// Reusable for username, phone, email, and password fields
class SignupInputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final bool enabled;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const SignupInputField({
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
