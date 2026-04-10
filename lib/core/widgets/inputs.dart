import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_text_styles.dart';

/// CustomInputField - Reusable input field with focus state
///
/// Features:
/// - Default and focus states with glow effect
/// - Error state support
/// - Prefix and suffix icons
/// - Custom label and hint
/// - Keyboard type configuration
/// - Input formatters
class CustomInputField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool isRequired;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const CustomInputField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.isRequired = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.focusNode,
    this.textInputAction,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final errorText = _validateField(widget.controller?.text);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Row(
            children: [
              Text(
                widget.label!,
                style: AppTextStyles.bodySmall,
              ),
              if (widget.isRequired) ...[
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '*',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.s),
        ],
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.inputBorder,
            border: Border.all(
              color: _getBorderColor(errorText),
              width: 1,
            ),
            boxShadow: _isFocused && errorText == null ? AppShadows.focusGlow : [],
          ),
          child: TextFormField(
            controller: widget.controller,
            initialValue: widget.initialValue,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            enabled: widget.enabled,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            maxLength: widget.maxLength,
            validator: widget.validator,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            inputFormatters: widget.inputFormatters,
            textInputAction: widget.textInputAction,
            style: AppTextStyles.bodyLarge,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.bodyLargeWithColor(
                AppColors.textSecondary,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.m,
                  right: AppSpacing.s,
                ),
                child: widget.prefixIcon,
              )
                  : null,
              suffixIcon: widget.suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.m,
                vertical: AppSpacing.m,
              ),
              counterText: '',
              errorStyle: const TextStyle(height: 0),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            errorText,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }

  Color _getBorderColor(String? errorText) {
    if (errorText != null) return AppColors.error;
    if (_isFocused) return AppColors.primary;
    return AppColors.border;
  }

  String? _validateField(String? value) {
    if (widget.validator != null) {
      return widget.validator!(value);
    }
    if (widget.isRequired && (value == null || value.isEmpty)) {
      return 'This field is required';
    }
    return null;
  }
}

/// SearchBar - Specialized input for search functionality
///
/// Features:
/// - Search icon prefix
/// - Clear button suffix
/// - Auto-focus support
class SearchBarField extends StatefulWidget {
  final String hint;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onClear;
  final FocusNode? focusNode;
  final bool autoFocus;

  const SearchBarField({
    super.key,
    this.hint = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.focusNode,
    this.autoFocus = false,
  });

  @override
  State<SearchBarField> createState() => _SearchBarFieldState();
}

class _SearchBarFieldState extends State<SearchBarField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChange);

    if (widget.autoFocus) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChange);
    _controller.dispose();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  void _onFocusChange() {
    setState(() {});
  }

  void _handleClear() {
    _controller.clear();
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.inputBorder,
        border: Border.all(
          color: _focusNode.hasFocus ? AppColors.primary : AppColors.border,
          width: 1,
        ),
        boxShadow: _focusNode.hasFocus ? AppShadows.focusGlow : [],
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        style: AppTextStyles.bodyLarge,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: AppTextStyles.bodyLargeWithColor(
            AppColors.textSecondary,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textSecondary,
            size: AppSpacing.iconSize,
          ),
          suffixIcon: _hasText
              ? IconButton(
            icon: const Icon(
              Icons.clear,
              color: AppColors.textSecondary,
              size: AppSpacing.iconSizeSmall,
            ),
            onPressed: _handleClear,
          )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.m,
            vertical: AppSpacing.m,
          ),
        ),
      ),
    );
  }
}

/// TextArea - Multi-line input field
///
/// Use for descriptions, bios, and longer text inputs
class TextArea extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final int maxLines;
  final int? maxLength;
  final bool isRequired;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const TextArea({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.maxLines = 4,
    this.maxLength,
    this.isRequired = false,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      label: label,
      hint: hint,
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      isRequired: isRequired,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
