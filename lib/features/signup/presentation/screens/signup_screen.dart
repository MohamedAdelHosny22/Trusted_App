import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_padding.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_auth_background.dart';
import '../../../../core/widgets/app_auth_header.dart';
import '../../data/data_sources/signup_remote_data_source.dart';
import '../../data/repositories/signup_repository.dart';
import '../cubit/signup_cubit.dart';
import '../cubit/signup_state.dart';
import '../widgets/login_link.dart';
import '../widgets/signup_form.dart';

/// SignupScreen - User registration screen
///
/// Features:
/// - Username/phone/email/password input with validation
/// - Reactive UI updates with BlocConsumer
/// - Loading states during registration
/// - Error handling with user feedback
/// - Navigation to login
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _createSignupCubit(),
      child: const _SignupContent(),
    );
  }

  SignupCubit _createSignupCubit() {
    final remoteDataSource = SignupRemoteDataSourceImpl();
    final repository = SignupRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );
    return SignupCubit(repository);
  }
}

class _SignupContent extends StatefulWidget {
  const _SignupContent();

  @override
  State<_SignupContent> createState() => _SignupContentState();
}

class _SignupContentState extends State<_SignupContent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    String phone = _phoneController.text.trim();
    
    // Add Egypt country code if not present
    if (phone.isNotEmpty && !phone.startsWith('+')) {
      if (phone.startsWith('0')) {
        phone = phone.substring(1);
      }
      phone = '+20$phone';
    }

    context.read<SignupCubit>().signup(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      userName: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      phoneNumber: phone,
    );
  }

  void _listenToSignupState(BuildContext context, SignupState state) {
    if (state.isSuccess) {
      context.go('/main?tab=0'); // Navigate to Home tab
    } else if (state.isFailure && state.errorMessage != null) {
      _showErrorSnackBar(context, state.errorMessage!);
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocConsumer<SignupCubit, SignupState>(
          listener: _listenToSignupState,
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
                          title: 'Create Account',
                          subtitle: 'Join Trusted today',
                          onBackPressed: () => context.go('/auth/login'),
                        ),

                        SignupForm(
                          firstNameController: _firstNameController,
                          lastNameController: _lastNameController,
                          usernameController: _usernameController,
                          phoneController: _phoneController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          isPasswordVisible: _isPasswordVisible,
                          isLoading: isLoading,
                          onSignup: _handleSignup,
                          onTogglePasswordVisibility: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),

                        const LoginLink(),

                        const SizedBox(height: AppSpacing.s),
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

