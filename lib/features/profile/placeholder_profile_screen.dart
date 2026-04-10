import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'presentation/cubit/profile_cubit.dart';
import 'presentation/screens/profile_screen.dart';

/// PlaceholderProfileScreen - Wrapper for ProfileScreen with dependency injection
///
/// Provides ProfileCubit with ProfileRepository to the ProfileScreen
class PlaceholderProfileScreen extends StatelessWidget {
  const PlaceholderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(ProfileRepositoryImpl()),
      child: const ProfileScreen(),
    );
  }
}
