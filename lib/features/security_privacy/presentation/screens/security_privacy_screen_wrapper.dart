import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trusted_app/features/security_privacy/cubit/security_privacy_cubit.dart';
import 'package:trusted_app/features/security_privacy/data/repositories/security_repository.dart';
import 'security_privacy_screen.dart';

/// Wrapper widget to provide BlocProvider to SecurityPrivacyScreen
///
/// This allows the router to properly inject dependencies
class SecurityPrivacyScreenWrapper extends StatelessWidget {
  const SecurityPrivacyScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SecurityPrivacyCubit(SecurityRepositoryImpl()),
      child: const SecurityPrivacyScreen(),
    );
  }
}
