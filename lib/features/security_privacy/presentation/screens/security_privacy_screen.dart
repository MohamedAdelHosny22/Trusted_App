import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trusted_app/core/theme/app_radius.dart';
import 'package:trusted_app/core/theme/app_text_styles.dart';
import 'package:trusted_app/features/security_privacy/cubit/security_privacy_cubit.dart';
import 'package:trusted_app/features/security_privacy/cubit/security_privacy_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/security_header_section.dart';
import '../widgets/security_option_item.dart';
import '../widgets/switch_option_item.dart';
import '../widgets/change_password_section.dart';

/// SecurityPrivacyScreen - Security & Privacy settings screen
///
/// Displays security options including password change, two-factor auth,
/// biometric auth, and other security-related settings
class SecurityPrivacyScreen extends StatefulWidget {
  const SecurityPrivacyScreen({super.key});

  @override
  State<SecurityPrivacyScreen> createState() => _SecurityPrivacyScreenState();
}

class _SecurityPrivacyScreenState extends State<SecurityPrivacyScreen> {
  // Password field controllers
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  // Password visibility toggles
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // Show password change section
  bool _showPasswordChange = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _handlePasswordChange() {
    context.read<SecurityPrivacyCubit>().changePassword(
          currentPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
          confirmNewPassword: _confirmNewPasswordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocListener<SecurityPrivacyCubit, SecurityPrivacyState>(
          listener: (context, state) {
            // Handle success
            if (state.isSuccess && state.successMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.successMessage!),
                  backgroundColor: AppColors.success,
                ),
              );
              // Clear password fields and hide section
              _currentPasswordController.clear();
              _newPasswordController.clear();
              _confirmNewPasswordController.clear();
              setState(() => _showPasswordChange = false);
              context.read<SecurityPrivacyCubit>().clearSuccess();
            }

            // Handle failure
            if (state.isFailure && state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: AppColors.error,
                ),
              );
              context.read<SecurityPrivacyCubit>().clearError();
            }
          },
          child: BlocBuilder<SecurityPrivacyCubit, SecurityPrivacyState>(
            builder: (context, state) {
              return Column(
                children: [
                  // Header
                  SecurityHeaderSection(
                    title: 'Security & Privacy',
                  ),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.m,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSpacing.m),

                          // Change Password Section
                          if (_showPasswordChange)
                            ChangePasswordSection(
                              currentPasswordController: _currentPasswordController,
                              newPasswordController: _newPasswordController,
                              confirmNewPasswordController: _confirmNewPasswordController,
                              obscureCurrentPassword: _obscureCurrentPassword,
                              obscureNewPassword: _obscureNewPassword,
                              obscureConfirmPassword: _obscureConfirmPassword,
                              onToggleCurrentPassword: () {
                                setState(() {
                                  _obscureCurrentPassword = !_obscureCurrentPassword;
                                });
                              },
                              onToggleNewPassword: () {
                                setState(() {
                                  _obscureNewPassword = !_obscureNewPassword;
                                });
                              },
                              onToggleConfirmPassword: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                              onSubmit: _handlePasswordChange,
                              isLoading: state.isLoading,
                            )
                          else
                            SecurityOptionItem(
                              icon: Icons.lock_outline,
                              title: 'Change Password',
                              description: 'Update your account password',
                              onTap: () {
                                setState(() => _showPasswordChange = true);
                              },
                            ),

                          const SizedBox(height: AppSpacing.m),

                          // Two-Factor Authentication
                          if (state.settings != null)
                            SwitchOptionItem(
                              icon: Icons.security,
                              title: 'Two-Factor Authentication',
                              description: 'Add an extra layer of security',
                              value: state.settings!.twoFactorEnabled,
                              onChanged: (value) {
                                context.read<SecurityPrivacyCubit>().toggleTwoFactor(value);
                              },
                            ),

                          // Biometric Authentication
                          if (state.settings != null)
                            SwitchOptionItem(
                              icon: Icons.fingerprint,
                              title: 'Biometric Authentication',
                              description: 'Use fingerprint or face recognition',
                              value: state.settings!.biometricEnabled,
                              onChanged: (value) {
                                context.read<SecurityPrivacyCubit>().toggleBiometric(value);
                              },
                            ),

                          const SizedBox(height: AppSpacing.m),

                          // Login Notifications
                          if (state.settings != null)
                            SwitchOptionItem(
                              icon: Icons.notifications_active,
                              title: 'Login Notifications',
                              description: 'Get notified of new sign-ins',
                              value: state.settings!.loginNotificationsEnabled,
                              onChanged: null, // Not implemented yet
                            ),

                          const SizedBox(height: AppSpacing.m),

                          // Account Security Info
                          if (state.settings != null)
                            _SecurityInfoCard(
                              label: 'Last Password Change',
                              value: _formatDate(state.settings!.lastPasswordChange),
                            ),

                          const SizedBox(height: AppSpacing.s),

                          if (state.settings != null)
                            _SecurityInfoCard(
                              label: 'Email Verification',
                              value: state.settings!.emailVerified ? 'Verified' : 'Not Verified',
                              isVerified: state.settings!.emailVerified,
                            ),

                          const SizedBox(height: AppSpacing.xl),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    if (dateString.isEmpty) return 'Never';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}

/// _SecurityInfoCard - Display card for security info
class _SecurityInfoCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isVerified;

  const _SecurityInfoCard({
    required this.label,
    required this.value,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.m),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall,
          ),
          Row(
            children: [
              if (isVerified)
                const Icon(
                  Icons.verified,
                  color: AppColors.success,
                  size: 16,
                ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                value,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: isVerified ? AppColors.success : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
