import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_radius.dart';
import '../../data/repositories/mediator_repository.dart';
import '../../data/datasources/mediator_local_data_source.dart';
import '../../data/models/payment_request_model.dart' as models;
import '../cubit/mediator_dashboard_cubit.dart';
import '../cubit/mediator_dashboard_state.dart';
import '../widgets/stats_overview_card.dart';
import '../widgets/payment_request_card.dart';
import 'payment_approval_detail_screen.dart';

/// MediatorDashboardScreen - Main dashboard for mediators
///
/// Features:
/// - Welcome header with user info
/// - Stats overview (highlighted section)
/// - Payment requests with filtering
/// - Clean visual hierarchy
/// - Organized sections
class MediatorDashboardScreen extends StatefulWidget {
  final bool hasAppBar;

  const MediatorDashboardScreen({
    super.key,
    this.hasAppBar = true, // Default: true (standalone use)
  });

  @override
  State<MediatorDashboardScreen> createState() =>
      _MediatorDashboardScreenState();
}

class _MediatorDashboardScreenState extends State<MediatorDashboardScreen> {
  late final MediatorDashboardCubit _cubit;
  models.PaymentRequestStatus? _selectedFilter = models.PaymentRequestStatus.pending; // Default: show only pending

  @override
  void initState() {
    super.initState();
    // Create cubit and load data
    _cubit = MediatorDashboardCubit(
      MediatorRepositoryImpl(
        localDataSource: MediatorLocalDataSource(),
      ),
    );
    // Load dashboard data on init
    _cubit.loadDashboard();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MediatorDashboardCubit>.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: widget.hasAppBar ? _buildAppBar() : null,
        body: BlocConsumer<MediatorDashboardCubit, MediatorDashboardState>(
          listener: (context, state) {
            if (state.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'An error occurred'),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading && state.paymentRequests.isEmpty) {
              return _buildLoadingState();
            }

            if (state.hasError && state.paymentRequests.isEmpty) {
              return _buildErrorState(state);
            }

            return RefreshIndicator(
              onRefresh: () => _cubit.loadDashboard(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.l),

                    // Stats Section - Highlighted
                    _buildStatsSection(state),

                    const SizedBox(height: AppSpacing.xl),

                    // Payment Requests Section
                    _buildPaymentRequestsSection(state),

                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        'Dashboard',
        style: AppTextStyles.heading3,
      ),
      actions: [
        // Notifications icon with badge
        BlocBuilder<MediatorDashboardCubit, MediatorDashboardState>(
          builder: (context, state) {
            final pendingCount = state.pendingCount;
            return Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () {
                    // TODO: Navigate to notifications screen
                  },
                ),
                if (pendingCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        pendingCount > 9 ? '9+' : pendingCount.toString(),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.background,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  /// Welcome Header - Greeting and pending alert
  /// Stats Section - Highlighted with card background
  Widget _buildStatsSection(MediatorDashboardState state) {
    if (state.stats == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.08),
            AppColors.primary.withValues(alpha: 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: StatsOverviewCard(stats: state.stats!),
      ),
    );
  }

  /// Payment Requests Section - Organized with clear structure
  Widget _buildPaymentRequestsSection(MediatorDashboardState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header with Filter
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment Requests',
                    style: AppTextStyles.heading3.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Filter Button
                  _buildFilterButton(state),
                ],
              ),
              const SizedBox(height: AppSpacing.m),

              // Filter Chips (only show when filter active)
              if (_selectedFilter != null) ...[
                _buildActiveFilterChip(),
                const SizedBox(height: AppSpacing.m),
              ],
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.m),

        // Payment Requests List
        _buildRequestsList(state),
      ],
    );
  }

  /// Filter Button - Opens filter bottom sheet
  Widget _buildFilterButton(MediatorDashboardState state) {
    return GestureDetector(
      onTap: () => _showFilterBottomSheet(context, state),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.s),
          border: Border.all(
            color: _selectedFilter != null
                ? AppColors.primary
                : AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getFilterIcon(),
              color: _selectedFilter != null
                  ? AppColors.primary
                  : AppColors.textSecondary,
              size: 16,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              _getFilterLabel(),
              style: AppTextStyles.bodySmall.copyWith(
                color: _selectedFilter != null
                    ? AppColors.primary
                    : AppColors.textSecondary,
                fontWeight: _selectedFilter != null
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Active Filter Chip - Shows current filter with clear option
  Widget _buildActiveFilterChip() {
    String label;
    Color color;

    switch (_selectedFilter) {
      case models.PaymentRequestStatus.pending:
        label = 'Pending';
        color = AppColors.warning;
        break;
      case models.PaymentRequestStatus.approved:
        label = 'Approved';
        color = AppColors.success;
        break;
      case models.PaymentRequestStatus.rejected:
        label = 'Rejected';
        color = AppColors.error;
        break;
      case null:
        return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getFilterIcon(),
            color: color,
            size: 14,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: AppSpacing.s),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = null;
              });
            },
            child: Icon(
              Icons.close,
              color: color,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context, MediatorDashboardState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(AppSpacing.l),
                child: Row(
                  children: [
                    Text(
                      'Filter Requests',
                      style: AppTextStyles.heading3,
                    ),
                    const Spacer(),
                    if (_selectedFilter != null)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedFilter = null;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Clear'),
                      ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // Filter Options
              _buildFilterOption(
                label: 'All Requests',
                count: state.paymentRequests.length,
                isSelected: _selectedFilter == null,
                onTap: () {
                  setState(() {
                    _selectedFilter = null;
                  });
                  Navigator.pop(context);
                },
              ),
              _buildFilterOption(
                label: 'Pending',
                count: state.pendingRequests.length,
                isSelected: _selectedFilter == models.PaymentRequestStatus.pending,
                onTap: () {
                  setState(() {
                    _selectedFilter = models.PaymentRequestStatus.pending;
                  });
                  Navigator.pop(context);
                },
              ),
              _buildFilterOption(
                label: 'Approved',
                count: state.approvedRequests.length,
                isSelected: _selectedFilter == models.PaymentRequestStatus.approved,
                onTap: () {
                  setState(() {
                    _selectedFilter = models.PaymentRequestStatus.approved;
                  });
                  Navigator.pop(context);
                },
              ),
              _buildFilterOption(
                label: 'Rejected',
                count: state.rejectedRequests.length,
                isSelected: _selectedFilter == models.PaymentRequestStatus.rejected,
                onTap: () {
                  setState(() {
                    _selectedFilter = models.PaymentRequestStatus.rejected;
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: AppSpacing.m),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterOption({
    required String label,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        isSelected ? Icons.check_circle : Icons.circle_outlined,
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(
        label,
        style: AppTextStyles.body.copyWith(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: Text(
        '$count',
        style: AppTextStyles.body.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      selected: isSelected,
      onTap: onTap,
    );
  }

  Widget _buildRequestsList(MediatorDashboardState state) {
    List<models.PaymentRequestModel> requests;

    switch (_selectedFilter) {
      case models.PaymentRequestStatus.pending:
        requests = state.pendingRequests;
        break;
      case models.PaymentRequestStatus.approved:
        requests = state.approvedRequests;
        break;
      case models.PaymentRequestStatus.rejected:
        requests = state.rejectedRequests;
        break;
      case null:
        requests = state.paymentRequests;
    }

    if (requests.isEmpty) {
      return _buildEmptyState();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Column(
        children: requests.map((request) {
          return PaymentRequestCard(
            request: request,
            onTap: () => _navigateToDetail(request),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildErrorState(MediatorDashboardState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSpacing.m),
            Text(
              'Error Loading Dashboard',
              style: AppTextStyles.heading3,
            ),
            const SizedBox(height: AppSpacing.s),
            Text(
              state.errorMessage ?? 'An unknown error occurred',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.l),
            ElevatedButton(
              onPressed: () {
                context.read<MediatorDashboardCubit>().loadDashboard();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _selectedFilter == null
                ? Icons.inbox_outlined
                : Icons.filter_list_off,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.m),
          Text(
            _selectedFilter == null
                ? 'No Payment Requests Yet'
                : 'No ${_selectedFilter!.name} Requests',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            _selectedFilter == null
                ? 'Payment requests will appear here when users send money'
                : 'Try selecting a different filter',
            style: AppTextStyles.body.copyWith(
              color: AppColors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getFilterIcon() {
    switch (_selectedFilter) {
      case models.PaymentRequestStatus.pending:
        return Icons.pending;
      case models.PaymentRequestStatus.approved:
        return Icons.check_circle;
      case models.PaymentRequestStatus.rejected:
        return Icons.cancel;
      case null:
        return Icons.filter_list;
    }
  }

  String _getFilterLabel() {
    switch (_selectedFilter) {
      case models.PaymentRequestStatus.pending:
        return 'Pending';
      case models.PaymentRequestStatus.approved:
        return 'Approved';
      case models.PaymentRequestStatus.rejected:
        return 'Rejected';
      case null:
        return 'Filter';
    }
  }

  void _navigateToDetail(models.PaymentRequestModel request) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentApprovalDetailScreen(request: request),
      ),
    );
  }
}
