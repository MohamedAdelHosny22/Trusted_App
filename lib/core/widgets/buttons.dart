import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_text_styles.dart';

/// PrimaryButton - Main call-to-action button
///
/// States:
/// - Default: Cyan background, glow effect
/// - Pressed: Scale 0.98
/// - Disabled: 30% opacity
class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? icon;
  final double? customHeight;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.customHeight,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.onPressed == null || widget.isLoading;
    final screenHeight = MediaQuery.of(context).size.height;
    final buttonHeight = widget.customHeight ?? screenHeight * 0.07;

    return GestureDetector(
      onTapDown: isDisabled ? null : (_) => setState(() => _isPressed = true),
      onTapUp: isDisabled ? null : (_) => setState(() => _isPressed = false),
      onTapCancel: isDisabled
          ? null
          : () => setState(() => _isPressed = false),
      child: Transform.scale(
        scale: _isPressed ? 0.98 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: buttonHeight.clamp(48, 64),
          width: widget.isFullWidth ? double.infinity : null,
          decoration: BoxDecoration(
            color: isDisabled
                ? AppColors.disabledBackground
                : AppColors.primary,
            borderRadius: AppRadius.buttonBorder,
            boxShadow: !isDisabled && !_isPressed ? AppShadows.primaryGlow : [],
            border: isDisabled ? null : Border.all(
              color: AppColors.primary,
              width: 1,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isDisabled ? null : widget.onPressed,
              borderRadius: AppRadius.buttonBorder,
              child: Center(
                child: widget.isLoading
                    ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.background),
                      ),
                    )
                    : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          widget.icon!,
                          const SizedBox(width: AppSpacing.s),
                        ],
                        Text(
                          widget.text,
                          style: AppTextStyles.primaryButtonText,
                        ),
                      ],
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// SecondaryButton - Outline style button
///
/// States:
/// - Default: Cyan border and text
/// - Pressed: Scale 0.98
/// - Disabled: Reduced opacity
class SecondaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? icon;
  final double? customHeight;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.customHeight,
  });

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.onPressed == null || widget.isLoading;

    return GestureDetector(
      onTapDown: isDisabled ? null : (_) => setState(() => _isPressed = true),
      onTapUp: isDisabled ? null : (_) => setState(() => _isPressed = false),
      onTapCancel: isDisabled
          ? null
          : () => setState(() => _isPressed = false),
      child: Transform.scale(
        scale: _isPressed ? 0.98 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: widget.customHeight ?? 56,
          width: widget.isFullWidth ? double.infinity : null,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: AppRadius.buttonBorder,
            border: Border.all(
              color: isDisabled
                  ? AppColors.textSecondary.withValues(alpha: 0.3)
                  : AppColors.primary,
              width: 1,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isDisabled ? null : widget.onPressed,
              borderRadius: AppRadius.buttonBorder,
              child: Center(
                child: widget.isLoading
                    ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDisabled
                              ? AppColors.textSecondary
                              : AppColors.primary,
                        ),
                      ),
                    )
                    : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          widget.icon!,
                          const SizedBox(width: AppSpacing.s),
                        ],
                        Text(
                          widget.text,
                          style: isDisabled
                              ? AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          )
                              : AppTextStyles.secondaryButtonText,
                        ),
                      ],
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// TextButton - Minimal text-only button
///
/// Use for tertiary actions
class TextActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final TextStyle? textStyle;

  const TextActionButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color ?? AppColors.primary,
        textStyle: textStyle ?? AppTextStyles.bodySmall,
      ),
      child: Text(text),
    );
  }
}

/// IconButton - Icon-only button with support
///
/// Use for actions like delete, edit, etc.
class ActionIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool showBackground;

  const ActionIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.showBackground = false,
  });

  @override
  State<ActionIconButton> createState() => _ActionIconButtonState();
}

class _ActionIconButtonState extends State<ActionIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.onPressed == null;

    return GestureDetector(
      onTapDown: isDisabled ? null : (_) => setState(() => _isPressed = true),
      onTapUp: isDisabled ? null : (_) => setState(() => _isPressed = false),
      onTapCancel: isDisabled
          ? null
          : () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: widget.showBackground
              ? (widget.backgroundColor ?? AppColors.surface)
              : Colors.transparent,
          borderRadius: AppRadius.chipBorder,
        ),
        padding: widget.showBackground
            ? const EdgeInsets.all(AppSpacing.s)
            : EdgeInsets.zero,
        child: Transform.scale(
          scale: _isPressed ? 0.95 : 1.0,
          child: Icon(
            widget.icon,
            size: AppSpacing.iconSize,
            color: widget.iconColor ??
                (isDisabled ? AppColors.textSecondary : AppColors.textPrimary),
          ),
        ),
      ),
    );
  }
}
