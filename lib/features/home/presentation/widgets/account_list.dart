import 'package:flutter/material.dart';
import 'package:trusted_app/features/home/data/models/account_model.dart';
import '../../../../core/theme/app_spacing.dart';
import 'account_card.dart';

class AccountList extends StatelessWidget {
  final List<AccountModel> accounts;
  final Function(AccountModel)? onAccountTap;

  const AccountList({
    super.key,
    required this.accounts,
    this.onAccountTap,
  });

  @override
  Widget build(BuildContext context) {
    if (accounts.isEmpty) {
      return _buildEmptyState();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate crossAxisCount based on screen width
          final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
          final childAspectRatio = _getChildAspectRatio(crossAxisCount);

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: AppSpacing.m,
              mainAxisSpacing: AppSpacing.m,
            ),
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts[index];
              return AccountCard(
                account: account,
                onTap: onAccountTap != null
                    ? () => onAccountTap!(account)
                    : null,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_outlined,
              size: 64,
              color: Colors.grey[600],
            ),
            const SizedBox(height: AppSpacing.m),
            Text(
              'No accounts found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: AppSpacing.s),
            Text(
              'Try adjusting your search or filters',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getCrossAxisCount(double screenWidth) {
    if (screenWidth < 600) return 2; // Small phones
    if (screenWidth < 900) return 3; // Large phones/tablets
    return 4; // Desktop
  }

  double _getChildAspectRatio(int crossAxisCount) {
    // Adjust aspect ratio based on grid columns
    switch (crossAxisCount) {
      case 2:
        return 0.75; // Taller cards for 2 columns
      case 3:
        return 0.7;
      default:
        return 0.65; // Shorter cards for more columns
    }
  }
}
