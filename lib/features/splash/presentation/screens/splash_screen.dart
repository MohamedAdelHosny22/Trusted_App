import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trusted_app/core/theme/app_shadows.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';
import '../widgets/splash_background.dart';

/// SplashScreen - App splash screen
///
/// Features:
/// - Show app logo with glow effect
/// - Check authentication status
/// - Navigate to appropriate screen
///
/// Architecture:
/// - UI → Cubit (navigation logic)
/// - BlocListener handles navigation
/// - Zero hardcoded styles
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..initialize(),
      child: const _SplashContent(),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  void _listenToSplashState(BuildContext context, SplashState state) {
    switch (state.status) {
      case SplashStatus.navigateHome:
        context.go('/main?tab=4'); // Navigate to main with Profile tab
        break;
      case SplashStatus.navigateOnboarding:
        context.go('/onboarding');
        break;
      case SplashStatus.navigateLogin:
        context.go('/auth/login');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<SplashCubit, SplashState>(
        listener: _listenToSplashState,
        child: Stack(
          children: [
            // Background gradient
            const SplashBackground(),

            // Centered content (vertical layout: logo on top, text below)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo image only (no text)
                  Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.primaryMaterial.shade800,
                      boxShadow: AppShadows.primaryGlow,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.primaryMaterial.shade600,
                        width: 0.6,
                      ),
                    ),
                    child:SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: 70,
                      height: 70,
                      fit: BoxFit.scaleDown,
                    ),
                  ),

                  SizedBox(height: AppSpacing.m),
                  // "Trusted" text below logo
                  Text(
                    'Trusted',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      height: 40 / 32,
                      letterSpacing: 4.8,
                      color: AppColors.textPrimary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
