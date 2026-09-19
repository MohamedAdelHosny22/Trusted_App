import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trusted_app/core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';
import '../widgets/splash_background.dart';

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
        context.go('/main?tab=4');
        break;
      case SplashStatus.navigateMediator:
        context.go('/mediator?tab=0');
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
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocListener<SplashCubit, SplashState>(
        listener: _listenToSplashState,
        child: Stack(
          children: [
            const SplashBackground(),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: theme.colorScheme.primary.withValues(alpha: 0.2), // Replace shade800
                      boxShadow: AppShadows.primaryGlow,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: theme.colorScheme.primary.withValues(alpha: 0.4), // Replace shade600
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
                  Text(
                    'Trusted',
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontSize: 32,
                      height: 40 / 32,
                      letterSpacing: 4.8,
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
