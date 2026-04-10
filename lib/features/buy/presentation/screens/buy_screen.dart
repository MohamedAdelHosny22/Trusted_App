import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/datasources/buy_remote_data_source.dart';
import '../../data/repositories/buy_repository_impl.dart';
import '../cubit/buy_cubit.dart';
import '../cubit/buy_state.dart';
import '../widgets/buy_button.dart';
import '../widgets/product_info_card.dart';
import '../widgets/quantity_selector.dart';

/// BuyScreen - Product purchase screen (Figma design)
class BuyScreen extends StatelessWidget {
  final String productId;

  const BuyScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _createBuyCubit(),
      child: _BuyContent(productId: productId),
    );
  }

  BuyCubit _createBuyCubit() {
    final repository = BuyRepositoryImpl(
      remoteDataSource: const BuyRemoteDataSource(),
    );
    return BuyCubit(repository: repository)..loadProduct(productId);
  }
}

class _BuyContent extends StatefulWidget {
  final String productId;

  const _BuyContent({required this.productId});

  @override
  State<_BuyContent> createState() => _BuyContentState();
}

class _BuyContentState extends State<_BuyContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BuyCubit>().loadProduct(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061012),
      appBar: _buildAppBar(context),
      body: BlocConsumer<BuyCubit, BuyState>(
        listener: (context, state) {
          _handleStateChanges(context, state);
        },
        builder: (context, state) {
          if (state is BuyLoading || state is BuyInitial) {
            return _buildLoadingState();
          }

          if (state is BuyError) {
            return _buildErrorState(state);
          }

          if (state is BuySuccess) {
            return _buildSuccessState(state);
          }

          if (state is BuyLoaded) {
            return _buildLoadedState(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF061012),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.textBright,
          size: 20,
        ),
        onPressed: () => context.pop(),
      ),
      title: const Text(
        'Buy Now',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textBright,
          height: 1.4,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: AppColors.textBright,
            size: 24,
          ),
          onPressed: () {
            // TODO: Navigate to cart
          },
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            backgroundColor: Color(0xFF1E3A42),
          ),
          SizedBox(height: 16),
          Text(
            'Loading product...',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuyError state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 24),
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textBright,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<BuyCubit>().loadProduct(widget.productId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: const Color(0xFF061012),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF061012),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState(BuySuccess state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 64,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Purchase Successful!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.textBright,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            PrimaryBuyButton(
              text: 'Continue Shopping',
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, BuyLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ProductImageSection(
            imageUrl: state.product.imageUrl,
            productName: state.product.name,
          ),
          const SizedBox(height: 20),

          // Product Info
          ProductInfoCard(product: state.product),
          const SizedBox(height: 20),

          // Quantity Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Quantity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBright,
                  height: 1.4,
                ),
              ),
              QuantitySelector(
                quantity: state.quantity,
                onDecrease: () => context.read<BuyCubit>().decreaseQuantity(),
                onIncrease: () => context.read<BuyCubit>().increaseQuantity(),
                canDecrease: state.canDecreaseQuantity,
                canIncrease: state.canIncreaseQuantity,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Total Price
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Total: ${state.product.formattedPrice}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.priceGreen,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Description
          ProductDescriptionSection(
            description: state.product.description,
          ),
          const SizedBox(height: 32),

          // Add to Cart Button
          SecondaryBuyButton(
            text: 'Add to Cart',
            icon: Icons.shopping_cart_outlined,
            onPressed: () => context.read<BuyCubit>().addToCart(),
          ),
          const SizedBox(height: 12),

          // Buy Now Button
          PrimaryBuyButton(
            text: 'Buy Now',
            price: state.product.formattedPrice,
            onPressed: () => context.read<BuyCubit>().purchase(),
          ),
          const SizedBox(height: 16),
          // Extra space for bottom navigation
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  void _handleStateChanges(BuildContext context, BuyState state) {
    if (state is BuyError) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
    }

    if (state is BuySuccess) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }
}
