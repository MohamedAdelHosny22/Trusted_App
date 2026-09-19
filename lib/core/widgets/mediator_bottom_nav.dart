import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

/// MediatorBottomNav - Bottom navigation bar for mediators
///
/// Similar to ProfileBottomNav with 4 items + floating Sell button:
/// - Dashboard (index 0)
/// - Buy (index 1)
/// - Sell (center floating button)
/// - Chats (index 2) - was index 3
/// - Profile (index 3) - was index 4
///
/// Design specifications:
/// - Height: 64px (without SafeArea)
/// - Background: #0f2223 (dark teal)
/// - Top border: #1e293b
/// - Active item: cyan color (#00EEFF)
/// - Inactive items: slate gray (#94A3B8)
/// - Sell button is elevated and circular (floating above nav bar)
class MediatorBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MediatorBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0F2223),
        border: Border(
          top: BorderSide(
            color: Color(0xFF1E293B),
            width: 1,
          ),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main nav bar content
          SafeArea(
            top: false,
            child: SizedBox(
              height: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Dashboard (index 0)
                  _buildNavIcon(
                    icon: Icons.dashboard_outlined,
                    activeIcon: Icons.dashboard,
                    label: 'Dashboard',
                    index: 0,
                    isSelected: currentIndex == 0,
                    onTap: onTap,
                  ),

                  // Buy (index 1)
                  _buildNavIcon(
                    icon: Icons.shopping_bag_outlined,
                    activeIcon: Icons.shopping_bag,
                    label: 'Buy',
                    index: 1,
                    isSelected: currentIndex == 1,
                    onTap: onTap,
                  ),

                  // Space for floating sell button
                  const SizedBox(width: 56),

                  // Chats (index 2) - was index 3
                  _buildNavIcon(
                    icon: Icons.chat_bubble_outline,
                    activeIcon: Icons.chat_bubble,
                    label: 'Chats',
                    index: 2,
                    isSelected: currentIndex == 2,
                    onTap: onTap,
                  ),

                  // Profile (index 3) - was index 4
                  _buildNavIcon(
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: 'Profile',
                    index: 3,
                    isSelected: currentIndex == 3,
                    onTap: onTap,
                  ),
                ],
              ),
            ),
          ),

          // Floating sell button (positioned outside the flow)
          Positioned(
            top: -24, // Half above the nav bar
            left: 0,
            right: 0,
            child: Center(
              child: Builder(
                builder: (context) => _buildSellButton(
                  isSelected: false, // Never selected since it opens a new screen
                  onTap: () => context.push('/sell/new'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required bool isSelected,
    required ValueChanged<int> onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColors.primary : const Color(0xFF94A3B8),
              size: isSelected ? 20 : 18,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : const Color(0xFF94A3B8),
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSellButton({
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
              spreadRadius: -4,
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: Color(0xFF0F2223),
          size: 24,
        ),
      ),
    );
  }
}
