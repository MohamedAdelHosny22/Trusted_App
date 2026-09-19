import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/payment_request_model.dart' as models;
import '../../data/repositories/mediator_repository.dart';
import '../../data/datasources/mediator_local_data_source.dart';
import '../cubit/mediator_dashboard_cubit.dart';
import '../cubit/mediator_dashboard_state.dart';
import '../widgets/approval_actions_widget.dart';


/// PaymentApprovalDetailScreen - Full payment request details
///
/// Shows:
/// - Complete transaction info
/// - Buyer and seller details
/// - Payment screenshot
/// - Approve/Reject actions
class PaymentApprovalDetailScreen extends StatefulWidget {
  final models.PaymentRequestModel request;

  const PaymentApprovalDetailScreen({
    super.key,
    required this.request,
  });

  @override
  State<PaymentApprovalDetailScreen> createState() =>
      _PaymentApprovalDetailScreenState();
}

class _PaymentApprovalDetailScreenState extends State<PaymentApprovalDetailScreen> {
  late final MediatorDashboardCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = MediatorDashboardCubit(
      MediatorRepositoryImpl(
        localDataSource: MediatorLocalDataSource(),
      ),
    );
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
      child: Builder(
        builder: (scaffoldContext) => Scaffold(
          backgroundColor: AppColors.background,
          appBar: _buildAppBar(scaffoldContext),
          body: BlocConsumer<MediatorDashboardCubit, MediatorDashboardState>(
          listener: (context, state) {
            if (state.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'An error occurred'),
                  backgroundColor: AppColors.error,
                ),
              );
            } else if (state.isLoaded) {
              // Check if the request was updated (status changed)
              final updatedRequest = state.paymentRequests.firstWhere(
                (r) => r.id == widget.request.id,
                orElse: () => widget.request,
              );

              // If status changed from pending, go back to dashboard
              if (widget.request.isPending &&
                  !updatedRequest.isPending &&
                  Navigator.of(context).canPop()) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      updatedRequest.isApproved
                          ? 'Payment approved successfully!'
                          : 'Payment rejected',
                    ),
                    backgroundColor: updatedRequest.isApproved
                        ? AppColors.success
                        : AppColors.warning,
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.l),

                  // Status banner
                  _buildStatusBanner(),

                  const SizedBox(height: AppSpacing.l),

                  // Account info
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.m,
                    ),
                    child: _buildAccountInfo(),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Participants
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.m,
                    ),
                    child: _buildParticipantsSection(),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Payment info
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.m,
                    ),
                    child: _buildPaymentInfo(),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Screenshot viewer
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.m,
                    ),
                    child: _buildScreenshotSection(),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Action buttons (if pending)
                  if (widget.request.isPending)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.m,
                      ),
                      child: ApprovalActionsWidget(
                        isLoading: state.isLoading,
                        onApprove: () => _handleApprove(context),
                        onReject: (reason) => _handleReject(context, reason),
                      ),
                    ),

                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            );
          },
        ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
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
        'Payment Review',
        style: AppTextStyles.heading3,
      ),
      actions: [
        if (widget.request.status != models.PaymentRequestStatus.pending)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: AppSpacing.m),
              child: Icon(
                widget.request.status == models.PaymentRequestStatus.approved
                    ? Icons.check_circle
                    : Icons.cancel,
                color: widget.request.status == models.PaymentRequestStatus.approved
                    ? AppColors.success
                    : AppColors.error,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStatusBanner() {
    String message;
    Color color;
    IconData icon;

    switch (widget.request.status) {
      case models.PaymentRequestStatus.pending:
        message = 'This payment is awaiting your review';
        color = AppColors.warning;
        icon = Icons.pending;
        break;
      case models.PaymentRequestStatus.approved:
        message = 'Payment approved - Chats created';
        color = AppColors.success;
        icon = Icons.check_circle;
        break;
      case models.PaymentRequestStatus.rejected:
        message = 'Payment rejected - Buyer notified';
        color = AppColors.error;
        icon = Icons.cancel;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(
          color: color.withValues(alpha:0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.body.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        Container(
          padding: const EdgeInsets.all(AppSpacing.m),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.cardRadius),
            border: Border.all(
              color: AppColors.border,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(AppRadius.s),
                ),
                child: const Icon(
                  Icons.gamepad,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.request.accountTitle,
                      style: AppTextStyles.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'ID: ${widget.request.accountId}',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Participants',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        _buildParticipantCard(
          label: 'Buyer',
          name: widget.request.buyerName,
          avatar: widget.request.buyerAvatar,
          id: widget.request.buyerId,
          isBuyer: true,
        ),
        const SizedBox(height: AppSpacing.m),
        _buildParticipantCard(
          label: 'Seller',
          name: widget.request.sellerName,
          avatar: widget.request.sellerAvatar,
          id: widget.request.sellerId,
          isBuyer: false,
        ),
      ],
    );
  }

  Widget _buildParticipantCard({
    required String label,
    required String name,
    String? avatar,
    required String id,
    required bool isBuyer,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(
          color: isBuyer
              ? AppColors.primary.withValues(alpha:0.3)
              : AppColors.accentPurple.withValues(alpha:0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          if (avatar != null && avatar.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.s),
              child: Image.network(
                avatar,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildDefaultAvatar(name);
                },
              ),
            )
          else
            _buildDefaultAvatar(name),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: (isBuyer ? AppColors.primary : AppColors.accentPurple)
                        .withValues(alpha:0.15),
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                  ),
                  child: Text(
                    label,
                    style: AppTextStyles.caption.copyWith(
                      color: isBuyer ? AppColors.primary : AppColors.accentPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  name,
                  style: AppTextStyles.bodyLarge,
                ),
                Text(
                  'ID: $id',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(String name) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.s),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Details',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        Container(
          padding: const EdgeInsets.all(AppSpacing.m),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.cardRadius),
            border: Border.all(
              color: AppColors.border,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    'EGP ${widget.request.amount.toStringAsFixed(2)}',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.priceGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.m),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Request Date',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    _formatDate(widget.request.createdAt),
                    style: AppTextStyles.body,
                  ),
                ],
              ),
              if (widget.request.reviewedAt != null) ...[
                const SizedBox(height: AppSpacing.m),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reviewed Date',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      _formatDate(widget.request.reviewedAt!),
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScreenshotSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Screenshot',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.cardRadius),
            border: Border.all(
              color: AppColors.primary.withValues(alpha:0.3),
              width: 1,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.image,
                  size: 64,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: AppSpacing.m),
                Text(
                  'Screenshot Preview',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.s),
                Text(
                  widget.request.screenshotPath,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleApprove(BuildContext context) {
    context.read<MediatorDashboardCubit>().approvePayment(widget.request.id);
  }

  void _handleReject(BuildContext context, String reason) {
    context.read<MediatorDashboardCubit>().rejectPayment(widget.request.id, reason);
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

