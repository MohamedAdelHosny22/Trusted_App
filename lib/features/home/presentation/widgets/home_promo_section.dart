import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_horizontal_card.dart';

class HomePromoSection extends StatelessWidget {
  const HomePromoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
        ),
        itemCount: 2,
        separatorBuilder: (context, index) => const SizedBox(width: 0),
        itemBuilder: (context, index) {
          if (index == 0) {
            return AppHorizontalCard(
              tag: 'EXCLUSIVE',
              title: 'Verified Mediators Now Available',
              buttonText: 'Learn More',
              tagColor: AppColors.eliteTier,
              onButtonTap: () {
                debugPrint('🏠 Promo: Learn More tapped');
              },
            );
          } else {
            return AppHorizontalCard(
              tag: 'DAILY',
              title: 'Upgrade Popular Accounts',
              buttonText: 'View',
              tagColor: AppColors.goldTier,
              onButtonTap: () {
                debugPrint('🏠 Promo: View tapped');
              },
            );
          }
        },
      ),
    );
  }
}
