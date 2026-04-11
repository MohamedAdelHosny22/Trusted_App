import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trusted_app/features/home/presentation/screens/home_screen.dart';
import '../../features/buy/presentation/screens/buy_accounts_screen.dart';
import '../../features/chat/presentation/screens/chat_list_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../theme/app_colors.dart';
import '../../features/profile/presentation/widgets/profile_bottom_nav.dart';

/// MainNavShell - Global navigation shell with bottom navigation
///
/// This is the main wrapper for authenticated screens
/// Uses IndexedStack to switch between screens without rebuilding
/// Bottom navigation is fixed and global
class MainNavShell extends StatefulWidget {
  final int initialIndex;

  const MainNavShell({
    super.key,
    this.initialIndex = 3, // Default to Profile tab (was 4, now 3)
  });

  @override
  State<MainNavShell> createState() => _MainNavShellState();
}

class _MainNavShellState extends State<MainNavShell> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Home Screen (index 0)
          const HomeScreen(),

          // Buy Screen (index 1)
          const BuyAccountsScreen(),

          // Chats Screen (index 2) - was index 3
          const ChatListScreen(),

          // Profile Screen (index 3) - was index 4 - with BlocProvider
          BlocProvider(
            create: (context) => ProfileCubit(
              ProfileRepositoryImpl(),
            )..loadProfileData(),
            child: const ProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: ProfileBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
