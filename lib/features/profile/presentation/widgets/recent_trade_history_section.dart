import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/models/trade_history_model.dart';
import 'trade_history_item.dart';

/// RecentTradeHistorySection - Recent trade history section
///
/// Displays section header with list of recent trades
/// Figma Design: Node 2312:59+
///
/// Design specifications:
/// - Section Title: "Recent Trade History", heading3 style
/// - "View All" link: primary color, Medium weight
/// - Item gap: 16px (AppSpacing.m)
/// - Horizontal padding: 16px (AppSpacing.m)
class RecentTradeHistorySection extends StatelessWidget {
  final List<TradeHistoryModel> tradeHistory;
  final VoidCallback? onViewAll;

  const RecentTradeHistorySection({
    super.key,
    required this.tradeHistory,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    if (tradeHistory.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 8),
        _buildTradeList(),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recent Trade History',
            style: AppTextStyles.heading3,
          ),
          GestureDetector(
            onTap: onViewAll,
            child: Text(
              'View All',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTradeList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tradeHistory.length,
        separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.m),
        itemBuilder: (context, index) {
          return TradeHistoryItem(
            key: ValueKey(tradeHistory[index].id),
            trade: tradeHistory[index],
          );
        },
      ),
    );
  }
}
