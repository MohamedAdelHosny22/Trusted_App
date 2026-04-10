import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_text_styles.dart';

/// CreateAccountLink - Navigation link to signup screen
///
/// Tappable text that navigates to signup screen
/// Uses design system text styles
class CreateAccountLink extends StatelessWidget {
  const CreateAccountLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: AppTextStyles.bodySmall,
          ),
          GestureDetector(
            onTap: () => context.go('/auth/signup'),
            child: Text(
              'Create an account',
              style: AppTextStyles.bodySmallPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
