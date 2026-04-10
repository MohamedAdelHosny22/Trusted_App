import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/buy_mediator_model.dart';
import '../widgets/mediator_card.dart';
import 'mediator_profile_screen.dart';
import 'payment_screen.dart';

/// ChooseMediatorScreen - Screen for selecting a mediator
///
/// Features:
/// - App bar with back button, title, and search icon
/// - Trust/security message banner
/// - Search functionality
/// - List of mediators with filtering
class ChooseMediatorScreen extends StatefulWidget {
  final List<BuyMediatorModel> mediators;
  final BuyMediatorModel? selectedMediator;

  const ChooseMediatorScreen({
    super.key,
    required this.mediators,
    this.selectedMediator,
  });

  @override
  State<ChooseMediatorScreen> createState() => _ChooseMediatorScreenState();
}

class _ChooseMediatorScreenState extends State<ChooseMediatorScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<BuyMediatorModel> _filteredMediators = [];

  @override
  void initState() {
    super.initState();
    _filteredMediators = widget.mediators;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredMediators = widget.mediators;
      } else {
        _filteredMediators = widget.mediators
            .where((mediator) =>
                mediator.name.toLowerCase().contains(query) ||
                mediator.specialization.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Trust message banner
          _buildTrustBanner(),

          const SizedBox(height: AppSpacing.m),

          // Search bar
          _buildSearchBar(),

          const SizedBox(height: AppSpacing.m),

          // Mediators list
          Expanded(
            child: _buildMediatorsList(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.textPrimary,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        'Choose a Mediator',
        style: AppTextStyles.heading3,
      ),
      actions: [
        // Search icon (toggles search bar visibility if needed)
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.m),
          child: IconButton(
            icon: const Icon(
              Icons.search,
              color: AppColors.textPrimary,
              size: 24,
            ),
            onPressed: () {
              // Focus on search field
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrustBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.security_rounded,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Text(
              'All mediators are verified and trusted by our platform',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: TextField(
          controller: _searchController,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: 'Search mediators...',
            hintStyle: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.textSecondary,
              size: 20,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(AppSpacing.m),
          ),
        ),
      ),
    );
  }

  Widget _buildMediatorsList() {
    if (_filteredMediators.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      itemCount: _filteredMediators.length,
      itemBuilder: (context, index) {
        final mediator = _filteredMediators[index];
        final isSelected = widget.selectedMediator?.id == mediator.id;

        return MediatorCard(
          mediator: mediator,
          isSelected: isSelected,
          onCardTap: () => _navigateToProfile(mediator),
          onSelectTap: () => _handleSelectMediator(mediator),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.person_search,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.m),
          Text(
            'No mediators found',
            style: AppTextStyles.heading3,
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            'Try adjusting your search',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  void _navigateToProfile(BuyMediatorModel mediator) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MediatorProfileScreen(
          mediator: mediator,
        ),
      ),
    );
  }

  void _handleSelectMediator(BuyMediatorModel mediator) {
    // Navigate to payment screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          mediator: mediator,
          amount: 100,
        ),
      ),
    );
  }
}
