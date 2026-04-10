import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_category_item.dart';
import '../../../../core/widgets/app_section_header.dart';

/// HomeCategoriesSection - Popular Games section
///
/// Displays a horizontal scrollable list of popular game categories
/// with circular icons and labels.
class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  static const List<Map<String, dynamic>> games = [
    {
      'label': 'PUBG',
      'imageUrl': 'assets/images/377aab6c8d17efa8c86ca94cf4e6cc0d.jpg',
    },
    {
      'label': 'Free Fire',
      'imageUrl': 'assets/images/26a8534fb2d7063e6157af9513b219d9.jpg',
    },
    {
      'label': 'Pes Mobile',
    },
    {
      'label': 'Clash Royale',
    },
    {
      'label': 'Clash of Clans',
    },
    {
      'label': 'Fifa Mobile',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSectionHeader(
          title: 'Popular Games',
          actionText: 'See All',
          onActionTap: () {
            context.push('/games');
          },
        ),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            itemCount: games.length,
            separatorBuilder: (context, index) => const SizedBox(width: 0),
            itemBuilder: (context, index) {
              final game = games[index];
              return AppCategoryItem(
                label: game['label'] as String,
                imageUrl: game['imageUrl'] as String?,
                onTap: () {
                  debugPrint('🏠 Game tapped: ${game['label']}');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
