import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// ProfileAvatar - Circular profile image with gradient border and camera button
///
/// Design specifications:
/// - Size: 150x150px
/// - Gradient border: cyan to purple (no padding, flush with image)
/// - Camera button: 36x36px, cyan, bottom-left, flush with image edge
/// - Fallback: Shows first letter of username if no image
class ProfileAvatar extends StatelessWidget {
  final String username;
  final String? imageUrl;
  final VoidCallback? onEdit;

  const ProfileAvatar({
    super.key,
    required this.username,
    this.imageUrl,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Profile image with gradient border
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.8),
                  AppColors.accentPurple.withValues(alpha: 0.8),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade800,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.background.withValues(alpha: 0.5),
                      blurRadius: 0,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildFallbackAvatar();
                          },
                        )
                      : _buildFallbackAvatar(),
                ),
              ),
            ),
          ),

          // Camera button - bottom-left, flush with image
          Positioned(
            bottom: 0,
            left: 0,
            child: GestureDetector(
              onTap: onEdit,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF0F2223),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Color(0xFF0F2223),
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return Container(
      color: const Color(0xFF1E293B),
      child: Center(
        child: Text(
          username.isNotEmpty ? username[0].toUpperCase() : '?',
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 48,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }
}
