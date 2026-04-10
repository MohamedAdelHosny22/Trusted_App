import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// WaitingScreen - Screen shown after payment submission
///
/// Features:
/// - Animated waiting indicator
/// - Expected wait time
/// - Contact support option
/// - Auto-check for confirmation
class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Auto-check every 30 seconds (simulated)
    _startAutoCheck();
  }

  void _startAutoCheck() {
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted) {
        _showCompletionDialog();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Confirming Payment',
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.textBright,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated icon
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.3),
                          AppColors.secondary.withValues(alpha: 0.2),
                        ],
                      ),
                      border: Border.all(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.hourglass_empty,
                      color: AppColors.primary,
                      size: 60,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Main message
                Text(
                  'Waiting for Mediator Confirmation',
                  style: AppTextStyles.heading2.copyWith(
                    color: AppColors.textBright,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.m),

                // Subtitle
                Text(
                  'Your payment is being verified by the mediator',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.xl),

                // Info cards
                _buildInfoCard(
                  icon: Icons.access_time,
                  title: 'Expected Wait Time',
                  description: 'Up to 24 hours',
                  color: AppColors.warning,
                ),

                const SizedBox(height: AppSpacing.m),

                _buildInfoCard(
                  icon: Icons.support_agent,
                  title: 'Need Help?',
                  description: 'Contact our support team',
                  color: AppColors.primary,
                ),

                const SizedBox(height: AppSpacing.xl * 2),

                // Check status button
                OutlinedButton.icon(
                  onPressed: () {
                    _showCompletionDialog();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Check Status'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textBright,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Text(
                'Payment Confirmed!',
                style: AppTextStyles.heading3.copyWith(
                  color: AppColors.textBright,
                ),
              ),
            ),
          ],
        ),
        content: const Text(
          'Your payment has been verified by the mediator. You can now access your account.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('Go to Home'),
          ),
        ],
      ),
    );
  }
}
