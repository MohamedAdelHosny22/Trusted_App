import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';

/// OnboardingPageContent - Content widget for each onboarding page
///
/// Displays illustration, title, and subtitle for each onboarding step
class OnboardingPageContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnboardingPageContent({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  /// Factory constructors for each onboarding page
  factory OnboardingPageContent.page1() {
    return const OnboardingPageContent(
      imagePath: 'assets/images/onboarding_1.png',
      title: 'Safe Gaming Account\nMarketplace',
      subtitle: 'Buy and sell gaming accounts safely\nwith trusted mediators.',
    );
  }

  factory OnboardingPageContent.page2() {
    return const OnboardingPageContent(
      imagePath: 'assets/images/onboarding_2.png',
      title: 'Secure Deals With\nMediators',
      subtitle: 'Choose a trusted mediator to\nsupervise the transaction between\nbuyer and seller.',
    );
  }

  factory OnboardingPageContent.page3() {
    return const OnboardingPageContent(
      imagePath: 'assets/images/onboarding_3.png',
      title: 'Trade With\nConfidence',
      subtitle: 'Use secure chats and share proof\nto complete deals safely.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration container
          _buildIllustrationContainer(context),
          SizedBox(height: ResponsiveUtils.scaleSpacing(context, AppSpacing.xl)),
          // Title
          _buildTitle(context),
          SizedBox(height: ResponsiveUtils.scaleSpacing(context, AppSpacing.m)),
          // Subtitle
          _buildSubtitle(context),
        ],
      ),
    );
  }

  Widget _buildIllustrationContainer(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageSize = screenSize.width * 0.8;
    final maxHeight = screenSize.height * 0.5;

    // Ensure height is constrained properly
    // Use max of 200 and the calculated imageSize, but ensure it doesn't exceed maxHeight
    final minHeight = 200.0;
    final calculatedHeight = imageSize < minHeight ? minHeight : imageSize;
    final finalHeight = calculatedHeight > maxHeight ? maxHeight : calculatedHeight;

    return SizedBox(
      width: imageSize,
      height: finalHeight,
      child: ClipRRect(
        borderRadius: AppRadius.cardBorder,
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: AppTextStyles.heading1.copyWith(
        fontSize: ResponsiveUtils.scaleFontSize(context, 30),
        height: 37.5 / 30,
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: AppTextStyles.bodyLarge.copyWith(
        fontSize: ResponsiveUtils.scaleFontSize(context, 18),
        height: 29.25 / 18,
        color: AppColors.textSecondary,
      ),
    );
  }
}
