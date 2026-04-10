import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_padding.dart';
import '../../../../core/widgets/app_auth_background.dart';
import '../../data/data_sources/login_remote_data_source.dart';
import '../../data/repositories/login_repository.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../widgets/create_account_link.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

/// LoginScreen - User authentication screen
///
/// Features:
/// - Username/password input with validation
/// - Reactive UI updates with BlocConsumer
/// - Loading states during authentication
/// - Error handling with user feedback
/// - Navigation to signup and password recovery
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _createLoginCubit(),
      child: const _LoginContent(),
    );
  }

  LoginCubit _createLoginCubit() {
    final remoteDataSource = const LoginRemoteDataSourceImpl();
    final repository = LoginRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );
    return LoginCubit(repository);
  }
}

class _LoginContent extends StatefulWidget {
  const _LoginContent();

  @override
  State<_LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<_LoginContent> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    context.read<LoginCubit>().login(
      username: _usernameController.text.trim(),
      password: _passwordController.text,
    );
  }

  void _listenToLoginState(BuildContext context, LoginState state) {
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
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: _listenToLoginState,
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
                      const LoginHeader(),

                      LoginForm(
                        usernameController: _usernameController,
                        passwordController: _passwordController,
                        isPasswordVisible: _isPasswordVisible,
                        isLoading: isLoading,
                        onLogin: _handleLogin,
                        onTogglePasswordVisibility: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),

                      const CreateAccountLink(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
