import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_radius.dart';
import '../../data/models/buy_account_model.dart';
import '../../data/models/buy_mediator_model.dart';
import '../cubit/buy_flow_cubit.dart';
import '../cubit/buy_flow_state.dart';

/// MediatorSelectorBottomSheet - Bottom sheet for selecting mediator
///
/// Shows:
/// - Account summary
/// - List of available mediators
/// - Mediator ratings and transaction counts
/// - Online status
/// - Payment methods preview
class MediatorSelectorBottomSheet extends StatelessWidget {
  final BuyAccountModel account;
  final Function(BuyMediatorModel) onMediatorSelected;

  const MediatorSelectorBottomSheet({
    super.key,
    required this.account,
    required this.onMediatorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          _buildHandleBar(),

          // Header
          _buildHeader(context),

          // Account summary
          _buildAccountSummary(),

          const Divider(height: 1, color: AppColors.border),

          // Mediators list
          Expanded(
            child: BlocBuilder<BuyFlowCubit, BuyFlowState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                }

                final mediators = state.mediators;

                if (mediators.isEmpty) {
                  return const Center(
                    child: Text(
                      'No mediators available',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.m),
                  itemCount: mediators.length,
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.m),
                  itemBuilder: (context, index) {
                    final mediator = mediators[index];
                    return _MediatorListItem(
                      mediator: mediator,
                      onTap: () {
                        context.read<BuyFlowCubit>().selectMediator(mediator);
                        onMediatorSelected(mediator);
                      },
                    );
                  },
                );
              },
            ),
          ),

          // Safe area for bottom
          const SafeArea(
            top: false,
            child: SizedBox(height: AppSpacing.m),
          ),
        ],
      ),
    );
  }

  Widget _buildHandleBar() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.m),
      child: Row(
        children: [
          const Icon(
            Icons.shield_moon,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Mediator',
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.textBright,
                  ),
                ),
                Text(
                  'Secure transaction guaranteed',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              color: AppColors.textSecondary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppRadius.m),
          border: Border.all(
            color: AppColors.border.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.2),
                    AppColors.secondary.withValues(alpha: 0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppRadius.s),
              ),
              child: Center(
                child: Text(
                  account.game.substring(0, 2).toUpperCase(),
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.title,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textBright,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    account.rank,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '\$${account.price.toInt()}',
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.priceGreen,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MediatorListItem extends StatelessWidget {
  final BuyMediatorModel mediator;
  final VoidCallback onTap;

  const _MediatorListItem({
    required this.mediator,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.m),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: name, rating, online status
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mediator.name,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textBright,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.warning,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            mediator.rating.toStringAsFixed(1),
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.s),
                          Text(
                            '•',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.s),
                          Text(
                            '${mediator.transactionsCount} transactions',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Online status indicator
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: mediator.isOnline
                        ? AppColors.priceGreen
                        : AppColors.textSecondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.m),

            // Specialization
            Text(
              mediator.specialization,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: AppSpacing.s),

            // Payment methods preview
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: mediator.paymentMethods.take(3).map((method) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.border.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getPaymentIcon(method.icon),
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        method.name,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: AppSpacing.m),

            // Response time
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  mediator.responseTime,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getPaymentIcon(String iconName) {
    switch (iconName) {
      case 'account_balance':
        return Icons.account_balance_wallet;
      case 'phone_iphone':
        return Icons.phone_android;
      case 'payment':
        return Icons.payment;
      default:
        return Icons.payments;
    }
  }
}
