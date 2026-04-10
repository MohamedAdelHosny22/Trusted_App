import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_padding.dart';
import '../../../../core/widgets/app_auth_background.dart';
import '../../../../core/widgets/app_auth_header.dart';
import '../../data/data_sources/forgot_password_remote_data_source.dart';
import '../../data/repositories/forgot_password_repository.dart';
import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_state.dart';
import '../widgets/back_to_login_link.dart';
import '../widgets/forgot_password_form.dart';

/// ForgotPasswordScreen - Password reset screen
///
/// Features:
/// - Email input with validation
/// - Reactive UI updates with BlocConsumer
/// - Loading states during password reset
/// - Error handling with user feedback
/// - Success message and navigation back to login
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _createForgotPasswordCubit(),
      child: const _ForgotPasswordContent(),
    );
  }

  ForgotPasswordCubit _createForgotPasswordCubit() {
    final remoteDataSource = const ForgotPasswordRemoteDataSourceImpl();
    final repository = ForgotPasswordRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );
    return ForgotPasswordCubit(repository);
  }
}

class _ForgotPasswordContent extends StatefulWidget {
  const _ForgotPasswordContent();

  @override
  State<_ForgotPasswordContent> createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<_ForgotPasswordContent> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendResetLink() {
    context.read<ForgotPasswordCubit>().sendResetLink(
      email: _emailController.text.trim(),
    );
  }

  void _listenToForgotPasswordState(BuildContext context, ForgotPasswordState state) {
    if (state.isSuccess) {
      _showSuccessSnackBar(context);
      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          context.go('/auth/login');
        }
      });
    } else if (state.isFailure && state.errorMessage != null) {
      _showErrorSnackBar(context, state.errorMessage!);
    }
  }

  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password reset link sent to your email'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: _listenToForgotPasswordState,
          builder: (context, state) {
            final isLoading = state.isLoading;

            return Stack(
              children: [
                const AppAuthBackground(),
                SafeArea(
                  child: SingleChildScrollView(
                    padding: AppPadding.screenHorizontalOnly,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppAuthHeader(
                          title: 'Forgot Password',
                          subtitle: 'Enter your email to receive a password reset link',
                          onBackPressed: () => context.go('/auth/login'),
                        ),

                        ForgotPasswordForm(
                          emailController: _emailController,
                          isLoading: isLoading,
                          onSendResetLink: _handleSendResetLink,
                        ),

                        const BackToLoginLink(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
