import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';

/// AppBottomNavigation - Custom bottom navigation bar
///
/// A floating navigation bar with a central "Sell" button.
/// Provides navigation to Home, Buy, Sell, Chats, and Profile sections.
///
/// This is a reusable component that can be used across multiple screens.
class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
        boxShadow: AppShadows.sm,
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 65,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Regular nav items
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _BottomNavItem(
                    icon: Icons.home,
                    label: 'Home',
                    route: '/main?tab=0',
                  ),
                  _BottomNavItem(
                    icon: Icons.shopping_bag_outlined,
                    label: 'Buy',
                    route: '/main?tab=1',
                  ),
                  // Space for floating button
                  const SizedBox(width: 56),
                  _BottomNavItem(
                    icon: Icons.chat_bubble_outline,
                    label: 'Chats',
                    route: '/main?tab=2', // Was tab=3
                  ),
                  _BottomNavItem(
                    icon: Icons.person_outline,
                    label: 'Profile',
                    route: '/main?tab=3', // Was tab=4
                  ),
                ],
              ),
              // Floating sell button
              Positioned(
                top: -20,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () => context.push('/sell/new'),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: AppShadows.primaryGlow,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.background,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Individual bottom navigation item
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? route;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;
    final active = route != null && currentRoute == route;

    return GestureDetector(
      onTap: () {
        if (route != null) {
          context.go(route!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.s,
          horizontal: AppSpacing.m,
        ),
        decoration: active
            ? BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppRadius.m),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: active ? AppColors.primary : AppColors.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: active ? AppColors.primary : AppColors.textSecondary,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
