import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'profile_avatar.dart';

/// ProfileHeader - Profile header section
///
/// Design specifications:
/// - Gradient background: cyan (10% opacity) to transparent
/// - Profile image: 150x150px, centered
/// - Border: 4px cyan gradient (no padding, flush with image)
/// - Edit button: camera icon, cyan button, bottom-left of image (flush)
/// - Username: "CyberHunter", 24px, bold
/// - Role: "Pro Trader" in cyan, 14px
/// - Member since: "Member since 2021", 14px, gray
class ProfileHeader extends StatelessWidget {
  final String username;
  final String? profileImageUrl;
  final String? userRole;
  final String? memberSince;
  final VoidCallback? onEditProfile;

  const ProfileHeader({
    super.key,
    required this.username,
    this.profileImageUrl,
    this.userRole = 'Pro Trader',
    this.memberSince,
    this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 56, 16, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.primary.withValues(alpha: 0.0),
          ],
        ),
      ),
      child: Column(
        children: [
          // Profile image with camera edit button
          ProfileAvatar(
            username: username,
            imageUrl: profileImageUrl,
            onEdit: onEditProfile,
          ),

          const SizedBox(height: 12),

          // Username
          Text(
            username,
            style: AppTextStyles.heading1.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.6,
              color: const Color(0xFFF1F5F9),
            ),
          ),

          const SizedBox(height: 4),

          // Role and member since
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pro Trader badge
              if (userRole != null)
                Text(
                  userRole!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),

              // Dot separator
              if (userRole != null && memberSince != null)
                Container(
                  width: 4,
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF64748B),
                    shape: BoxShape.circle,
                  ),
                ),

              // Member since
              if (memberSince != null)
                Text(
                  memberSince!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: const Color(0xFF94A3B8),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
