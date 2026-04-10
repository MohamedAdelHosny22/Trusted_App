import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_radius.dart';

/// AddNewListingCard - Card for adding new listing
///
/// Displays a dashed-bordered card with add icon and label
/// Figma Design: Node 2312:35
///
/// Design specifications:
/// - Width: 128px, Height: 176px
/// - Border: 2px, dashed, borderSubtle color (#334155)
/// - Dash pattern: 6px dash, 4px gap
/// - Border Radius: 12px (AppRadius.m)
/// - Icon circle: 40px, primary (10% opacity)
/// - Plus icon: 14px, primary color
/// - Text: "Add New", 12px, Bold, textTertiary color
class AddNewListingCard extends StatelessWidget {
  final VoidCallback? onTap;

  const AddNewListingCard({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 128,
        height: 176,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.m),
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            // Dashed border overlay
            Positioned.fill(
              child: CustomPaint(
                painter: _DashedBorderPainter(
                  color: AppColors.borderSubtle,
                  strokeWidth: 2,
                  dashArray: [8, 6],
                ),
              ),
            ),
            // Centered content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Plus icon in circle
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Add New',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textTertiary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
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

/// Custom painter for dashed border
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashArray;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashArray,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Create rounded rectangle path
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(12), // AppRadius.m
    );

    // Draw dashed border
    final path = Path()..addRRect(rrect);
    final dashPath = Path();

    double distance = 0.0;
    bool draw = true;

    for (final metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final double len = draw ? dashArray[0] : dashArray[1];
        if (draw) {
          dashPath.addPath(
            metric.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len;
        draw = !draw;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
