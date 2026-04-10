import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../data/models/trade_history_model.dart';

/// TradeHistoryItem - Single trade history item
///
/// Displays trade with status icon, title, timestamp and price
/// Figma Design: Node 2312:60+
///
/// Design specifications:
/// - Padding: 12px (all sides)
/// - Background: cardSurface (40% opacity)
/// - Border: 1px, cardSurface color
/// - Border Radius: 12px (AppRadius.m)
/// - Status Icon: 40px circle, status color (10% opacity bg)
/// - Title: 12px, Bold, textBright color
/// - Status text: 10px, Medium, textTertiary color
/// - Price: 16px, Black (900 weight), priceGreen color
class TradeHistoryItem extends StatelessWidget {
  final TradeHistoryModel trade;

  const TradeHistoryItem({
    super.key,
    required this.trade,
  });

  Color _getStatusColor() {
    switch (trade.status.toLowerCase()) {
      case 'completed':
        return AppColors.statusSuccess; // Figma: #10B981
      case 'pending':
        return AppColors.warning;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  IconData _getStatusIcon() {
    switch (trade.status.toLowerCase()) {
      case 'completed':
        return Icons.check_circle;
      case 'pending':
        return Icons.pending;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  String _getStatusText() {
    switch (trade.status.toLowerCase()) {
      case 'completed':
        return 'Completed';
      case 'pending':
        return 'Pending';
      case 'cancelled':
        return 'Cancelled';
      default:
        return trade.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Container(
      padding: const EdgeInsets.all(12), // Figma: 12px padding
      decoration: BoxDecoration(
        color: AppColors.cardSurface.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppRadius.m),
        border: Border.all(
          color: AppColors.cardSurface,
          width: 1,
        ),
        boxShadow: AppShadows.sm,
      ),
      child: Row(
        children: [
          _buildStatusIcon(statusColor),
          const SizedBox(width: AppSpacing.m),
          Expanded(child: _buildTradeInfo()),
          _buildPrice(),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _getStatusIcon(),
        color: color,
        size: AppSpacing.iconSize,
      ),
    );
  }

  Widget _buildTradeInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          trade.title,
          style: AppTextStyles.cardTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          '${_getStatusText()} • ${trade.timeAgo}',
          style: AppTextStyles.smallMediumText,
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return Text(
      '\$${trade.price.toInt()}',
      style: AppTextStyles.heading3.copyWith(
        color: AppColors.priceGreen,
        fontWeight: FontWeight.w900,
        fontSize: 16,
      ),
    );
  }
}
