import 'package:flutter/material.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import 'forgot_password_link.dart';

/// LoginForm - Login form with email and password fields
class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final bool isLoading;
  final VoidCallback onLogin;
  final VoidCallback onTogglePasswordVisibility;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.isLoading,
    required this.onLogin,
    required this.onTogglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _EmailField(
          controller: emailController,
          isLoading: isLoading,
        ),

        _PasswordField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          isLoading: isLoading,
          onToggleVisibility: onTogglePasswordVisibility,
        ),

        const ForgotPasswordLink(),

        AppPrimaryButton(
          text: 'Log In',
          onPressed: onLogin,
          isLoading: isLoading,
        ),
      ],
    );
  }
}

class _EmailField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;

  const _EmailField({
    required this.controller,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Email Address',
      hint: 'Enter your email address',
      controller: controller,
      enabled: !isLoading,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(
        Icons.email,
        size: 16,
        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final bool isLoading;
  final VoidCallback onToggleVisibility;

  const _PasswordField({
    required this.controller,
    required this.obscureText,
    required this.isLoading,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Password',
      hint: 'Enter your password',
      controller: controller,
      obscureText: obscureText,
      enabled: !isLoading,
      prefixIcon: Icon(
        Icons.lock,
        size: 21,
        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
      ),
      suffixIcon: _PasswordVisibilityToggle(
        isVisible: !obscureText,
        onTap: onToggleVisibility,
      ),
    );
  }
}

class _PasswordVisibilityToggle extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onTap;

  const _PasswordVisibilityToggle({
    required this.isVisible,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isVisible ? Icons.visibility_off : Icons.visibility,
        size: 22,
        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
      ),
    );
  }
}
