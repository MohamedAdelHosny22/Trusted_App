import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// QuantitySelector - Widget for selecting product quantity (Figma design)
class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final bool canDecrease;
  final bool canIncrease;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    this.canDecrease = true,
    this.canIncrease = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A42),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF334155),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            icon: Icons.remove,
            onPressed: canDecrease ? onDecrease : null,
          ),
          Container(
            width: 48,
            alignment: Alignment.center,
            child: Text(
              quantity.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textBright,
              ),
            ),
          ),
          _buildButton(
            icon: Icons.add,
            onPressed: canIncrease ? onIncrease : null,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    final isEnabled = onPressed != null;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 20,
          color: isEnabled
              ? AppColors.primary
              : const Color(0xFF546E7A),
        ),
      ),
    );
  }
}
