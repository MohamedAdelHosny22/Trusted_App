import 'package:flutter/material.dart';
import '../widgets/onboarding_page_content.dart';

class OnboardingPageView extends StatelessWidget {
  final PageController controller;
  final ValueChanged<int> onPageChanged;

  const OnboardingPageView({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: onPageChanged,
      itemCount: 3,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return OnboardingPageContent.page1();
          case 1:
            return OnboardingPageContent.page2();
          case 2:
            return OnboardingPageContent.page3();
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
