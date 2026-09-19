import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trusted_app/features/mediator_dashboard/presentation/screens/mediator_dashboard_screen.dart';
import '../../features/buy/presentation/screens/buy_accounts_screen.dart';
import '../../features/chat/presentation/screens/chat_list_screen.dart';
import '../../features/profile/presentation/screens/mediator_profile_screen.dart';
import '../../features/profile/presentation/cubit/mediator_profile_cubit.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../theme/app_colors.dart';
import 'mediator_bottom_nav.dart';

/// MediatorNavShell - Navigation shell for authenticated mediators
///
/// This is the main wrapper for authenticated mediator screens
/// Uses IndexedStack to switch between screens without rebuilding
/// Bottom navigation is fixed and has 5 tabs:
/// 0: Dashboard (stats, payment requests, approvals)
/// 1: Buy (browse and purchase accounts)
/// 2: Sell (list own accounts for sale)
/// 3: Chats (view conversations)
/// 4: Profile (earnings, tier, stats)
class MediatorNavShell extends StatefulWidget {
  final int initialIndex;

  const MediatorNavShell({
    super.key,
    this.initialIndex = 0, // Default to Dashboard
  });

  @override
  State<MediatorNavShell> createState() => _MediatorNavShellState();
}

class _MediatorNavShellState extends State<MediatorNavShell> {
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
          // Dashboard Screen (index 0) - No appbar since in nav shell
          const MediatorDashboardScreen(hasAppBar: false),

          // Buy Screen (index 1) - Complete reuse
          const BuyAccountsScreen(),

          // Chats Screen (index 2) - Complete reuse (was index 3)
          const ChatListScreen(),

          // Profile Screen (index 3) - Mediator-specific with BlocProvider (was index 4)
          BlocProvider(
            create: (context) => MediatorProfileCubit(
              ProfileRepositoryImpl(),
            )..loadMediatorProfile(),
            child: const MediatorProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: MediatorBottomNav(
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
