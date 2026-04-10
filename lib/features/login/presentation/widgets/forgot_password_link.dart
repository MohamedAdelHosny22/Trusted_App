import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_padding.dart';
import '../../../../core/theme/app_text_styles.dart';

/// ForgotPasswordLink - Navigation link for password recovery
///
/// Tappable text that navigates to password reset screen
/// Uses design system link text style
class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: AppPadding.button,
        ),
        child: GestureDetector(
          onTap: () => context.go('/auth/forgot-password'),
          child: Text(
            'Forgot password?',
            style: AppTextStyles.linkText,
          ),
        ),
      ),
    );
  }
}
