import 'package:flutter/material.dart';
import 'package:trusted_app/features/home/presentation/cubit/home_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_section_header.dart';
import '../../../buy/data/models/buy_account_model.dart';
import '../../../buy/data/models/buy_mediator_model.dart';
import '../../../buy/presentation/screens/account_details_screen.dart';
import 'account_card.dart';

class HomeFeaturedSection extends StatelessWidget {
  const HomeFeaturedSection({required this.state, super.key});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppSectionHeader(
          title: 'Featured Accounts',
          showAction: false,
        ),
        if (state.isLoading)
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.70, // Balanced ratio
                crossAxisSpacing: AppSpacing.m,
                mainAxisSpacing: AppSpacing.m,
              ),
              itemCount: state.accounts.length,
              itemBuilder: (context, index) {
                final account = state.accounts[index];
                return AccountCard(
                  account: account,
                  sellerName: 'Seller ${index + 1}',
                  onTap: () {
                    _navigateToAccountDetails(context, account, index);
                  },
                  onViewDetails: () {
                    _navigateToAccountDetails(context, account, index);
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  void _navigateToAccountDetails(
    BuildContext context,
    dynamic account,
    int index,
  ) {
    // Convert home AccountModel to BuyAccountModel
    final buyAccount = BuyAccountModel(
      id: account.id ?? 'home_$index',
      title: account.title,
      game: account.game,
      rank: account.categoryId ?? 'Standard',
      price: account.price,
      seller: 'Seller ${index + 1}',
      sellerAvatar: '',
      rating: account.rating,
      reviewsCount: account.reviews,
      description: 'Featured ${account.game} account with great progression and items.',
      images: [
        account.imageUrl,
        if (account.imageUrl.contains('placeholder')) ...[
          'https://via.placeholder.com/400x400/1E3A42/00EEFF?text=Image+2',
          'https://via.placeholder.com/400x400/1E3A42/00EEFF?text=Image+3',
        ],
      ],
      features: const [],
      isVerified: true,
      isFeatured: account.isPremium,
    );

    // Create default mediator
    final mediator = BuyMediatorModel(
      id: 'home_mediator_$index',
      name: 'Seller ${index + 1}',
      avatar: '',
      rating: account.rating,
      programRating: account.rating,
      transactionsCount: account.reviews + 50,
      specialization: account.game,
      paymentMethods: const [],
      responseTime: 'Available now',
      isOnline: true,
      tier: MediatorTier.bronze,
      isVerified: false,
      badges: const [],
      bio: 'Professional mediator for ${account.game}',
    );

    // Navigate to account details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AccountDetailsScreen(
          account: buyAccount,
          mediator: mediator,
        ),
      ),
    );
  }
}
