import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_text_styles.dart';

/// LoginLink - Navigation link to login screen
///
/// Tappable text that navigates to login screen
/// Uses design system text styles
class LoginLink extends StatelessWidget {
  const LoginLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: AppTextStyles.bodySmall,
          ),
          GestureDetector(
            onTap: () => context.go('/auth/login'),
            child: Text(
              'Log in',
              style: AppTextStyles.bodySmallPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
