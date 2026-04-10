import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';

/// QuickActionsSection - Quick actions section matching Figma design
///
/// Figma Design: Node 2312:86
/// Design specifications:
/// - Section Title: "Quick Actions", 18px, bold
/// - Container background: cardSurface with 30% opacity
/// - Border: 1px, cardSurface color
/// - Border radius: 16px
/// - Items:
///   1. Notifications (with cyan dot indicator)
///   2. Security & Privacy
///   3. Help Center
///   4. Logout (red text)
class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
          child: Text(
            'Quick Actions',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 28 / 18,
              color: const Color(0xFFF1F5F9),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.m),

        // Actions Container
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cardSurface.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(AppRadius.l),
              border: Border.all(
                color: const Color(0xFF1E293B),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                _NotificationItem(),
                _Divider(),
                _SecurityItem(),
                _Divider(),
                _HelpCenterItem(),
                _LogoutItem(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: const Color(0xFF1E293B).withValues(alpha: 0.5),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem();

  @override
  Widget build(BuildContext context) {
    return _QuickActionItem(
      icon: Icons.notifications_outlined,
      iconSize: 20,
      title: 'Notifications',
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cyan indicator dot
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.6),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Chevron
          const Icon(
            Icons.chevron_right,
            color: AppColors.textTertiary,
            size: 12,
          ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, '/notifications');
      },
    );
  }
}

class _SecurityItem extends StatelessWidget {
  const _SecurityItem();

  @override
  Widget build(BuildContext context) {
    return _QuickActionItem(
      icon: Icons.security_outlined,
      iconSize: 16,
      title: 'Security & Privacy',
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textTertiary,
        size: 12,
      ),
      onTap: () {
        Navigator.pushNamed(context, '/security-privacy');
      },
    );
  }
}

class _HelpCenterItem extends StatelessWidget {
  const _HelpCenterItem();

  @override
  Widget build(BuildContext context) {
    return _QuickActionItem(
      icon: Icons.help_outline,
      iconSize: 18,
      title: 'Help Center',
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textTertiary,
        size: 12,
      ),
      onTap: () {
        // TODO: Navigate to help center
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Help Center - Coming Soon')),
        );
      },
    );
  }
}

class _LogoutItem extends StatelessWidget {
  const _LogoutItem();

  @override
  Widget build(BuildContext context) {
    return _QuickActionItem(
      icon: Icons.logout,
      iconSize: 18,
      title: 'Logout',
      titleColor: const Color(0xFFEF4444), // Red color for logout
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textTertiary,
        size: 12,
      ),
      onTap: () {
        _showLogoutDialog(context);
      },
    );
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: const Color(0xFF1E293B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        'Logout',
        style: AppTextStyles.heading3.copyWith(
          color: const Color(0xFFF1F5F9),
        ),
      ),
      content: Text(
        'Are you sure you want to logout?',
        style: AppTextStyles.body.copyWith(
          color: const Color(0xFF94A3B8),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(
            'Cancel',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            // TODO: Implement logout logic
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logging out...')),
            );
          },
          child: Text(
            'Logout',
            style: AppTextStyles.bodySmall.copyWith(
              color: const Color(0xFFEF4444),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Reusable quick action item widget matching Figma design
class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String title;
  final Color? titleColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _QuickActionItem({
    required this.icon,
    this.iconSize = 20,
    required this.title,
    this.titleColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: 16,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.textSecondary,
              size: iconSize,
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 20 / 14,
                  color: titleColor ?? const Color(0xFFE2E8F0),
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
