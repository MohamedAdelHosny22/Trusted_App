import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_faq_item.dart';

class HomeFaqSection extends StatelessWidget {
  const HomeFaqSection({super.key});

  static const List<Map<String, String>> faqs = [
    {
      'question': 'How do I buy an account?',
      'answer':
          'Browse our featured accounts, select the one you want, and complete the secure checkout process.',
    },
    {
      'question': 'Is the trading secure?',
      'answer':
          'Yes! All transactions are mediated by verified mediators to ensure security for both buyers and sellers.',
    },
    {
      'question': 'How long does delivery take?',
      'answer':
          'Most accounts are delivered instantly after purchase. Some may take up to 24 hours.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
            vertical: AppSpacing.m,
          ),
          child: Text(
            'FAQs',
            style: AppTextStyles.heading2,
          ),
        ),
        ...faqs.map((faq) => AppFaqItem(
              question: faq['question']!,
              answer: faq['answer']!,
            )),
      ],
    );
  }
}
