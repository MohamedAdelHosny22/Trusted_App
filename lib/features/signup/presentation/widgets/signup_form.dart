import 'package:flutter/material.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final bool isLoading;
  final VoidCallback onSignup;
  final VoidCallback onTogglePasswordVisibility;

  const SignupForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.isLoading,
    required this.onSignup,
    required this.onTogglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FirstNameField(
                controller: firstNameController,
                isLoading: isLoading,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _LastNameField(
                controller: lastNameController,
                isLoading: isLoading,
              ),
            ),
          ],
        ),

        _UsernameField(
          controller: usernameController,
          isLoading: isLoading,
        ),

        _PhoneField(
          controller: phoneController,
          isLoading: isLoading,
        ),

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

        AppPrimaryButton(
          text: 'Create Account',
          onPressed: onSignup,
          isLoading: isLoading,
        ),
      ],
    );
  }
}

class _FirstNameField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;

  const _FirstNameField({
    required this.controller,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'First Name',
      hint: 'Enter your first name',
      controller: controller,
      enabled: !isLoading,
      prefixIcon: Icon(
        Icons.person_outline,
        size: 16,
        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
      ),
    );
  }
}

class _LastNameField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;

  const _LastNameField({
    required this.controller,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Last Name',
      hint: 'Enter your last name',
      controller: controller,
      enabled: !isLoading,
      prefixIcon: Icon(
        Icons.person_outline,
        size: 16,
        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
      ),
    );
  }
}

class _UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;

  const _UsernameField({
    required this.controller,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Username',
      hint: 'Enter your username',
      controller: controller,
      enabled: !isLoading,
      prefixIcon: Icon(
        Icons.person,
        size: 16,
        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;

  const _PhoneField({
    required this.controller,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Phone Number',
      hint: 'Enter your phone number',
      controller: controller,
      enabled: !isLoading,
      keyboardType: TextInputType.phone,
      prefixIcon: Icon(
        Icons.phone,
        size: 16,
        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
      ),
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
      label: 'Email',
      hint: 'Enter your email',
      controller: controller,
      enabled: !isLoading,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(
        Icons.email_outlined,
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
