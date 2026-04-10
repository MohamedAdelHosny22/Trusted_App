import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/fullscreen_image_viewer.dart';
import '../../data/models/buy_account_model.dart';
import '../../data/models/buy_mediator_model.dart';
import '../cubit/buy_flow_cubit.dart';
import '../cubit/buy_flow_state.dart';

/// AccountDetailsScreen - Account details matching Figma design
///
/// Features:
/// - Image gallery with main view and thumbnails
/// - Short title/description
/// - Price in EGP
/// - Trust banner
/// - Full account details
/// - Seller info card
/// - Request to Buy button
class AccountDetailsScreen extends StatelessWidget {
  final BuyAccountModel account;
  final BuyMediatorModel? mediator;

  const AccountDetailsScreen({
    super.key,
    required this.account,
    this.mediator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BuyFlowCubit()
        ..selectAccount(account)
        ..selectMediator(mediator ?? _createDefaultMediator()),
      child: const _AccountDetailsContent(),
    );
  }

  BuyMediatorModel _createDefaultMediator() {
    return BuyMediatorModel(
      id: 'default',
      name: account.seller,
      avatar: account.sellerAvatar,
      rating: account.rating,
      programRating: account.rating,
      transactionsCount: account.reviewsCount,
      specialization: account.game,
      paymentMethods: const [],
      responseTime: 'Available now',
      isOnline: true,
      tier: MediatorTier.bronze,
      isVerified: false,
      badges: const [],
      bio: 'Professional mediator for ${account.game}',
    );
  }
}

class _AccountDetailsContent extends StatefulWidget {
  const _AccountDetailsContent();

  @override
  State<_AccountDetailsContent> createState() => _AccountDetailsContentState();
}

class _AccountDetailsContentState extends State<_AccountDetailsContent> {
  int _selectedImageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedImageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: BlocBuilder<BuyFlowCubit, BuyFlowState>(
          builder: (context, state) {
            final account = state.selectedAccount;
            final mediator = state.selectedMediator;

            if (account == null || mediator == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image gallery
                  _buildImageGallery(account),

                  const SizedBox(height: 16),

                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      account.title,
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.textBright,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Price in EGP
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'EGP ',
                          style: AppTextStyles.heading3.copyWith(
                            color: AppColors.textBright,
                          ),
                        ),
                        Text(
                          _formatPriceInEGP(account.price),
                          style: AppTextStyles.heading1.copyWith(
                            color: AppColors.primary,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Trust banner
                  _buildTrustBanner(),

                  const SizedBox(height: 20),

                  // Account details section
                  _buildAccountDetailsSection(account),

                  const SizedBox(height: 20),

                  // Seller info card
                  _buildSellerInfoCard(mediator),

                  const SizedBox(height: 100), // Space for button
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBuyButton(context),
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
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Account Details',
        style: AppTextStyles.heading3.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildImageGallery(BuyAccountModel account) {
    final images = account.images.isNotEmpty
        ? account.images
        : ['assets/accounts/account_1.jpeg'];

    return Column(
      children: [
        // Main image (tappable to open fullscreen)
        GestureDetector(
          onTap: () {
            // Open fullscreen viewer
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullscreenImageViewer(
                  images: images,
                  initialIndex: _selectedImageIndex,
                ),
              ),
            );
          },
          child: SizedBox(
            height: 300,
            child: PageView.builder(
              controller: _pageController, // Add controller
              onPageChanged: (index) {
                setState(() {
                  _selectedImageIndex = index;
                });
              },
              itemCount: images.length,
              itemBuilder: (context, index) {
                return _buildAccountImage(images[index]);
              },
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Thumbnails
        if (images.length > 1)
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Change main image to this thumbnail with animation
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: index == _selectedImageIndex
                            ? AppColors.primary
                            : AppColors.border,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: _buildAccountImage(images[index]),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  /// Build account image (supports both assets and network URLs)
  Widget _buildAccountImage(String imagePath) {
    // Check if it's an asset path
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.surface,
            child: const Icon(
              Icons.image_not_supported,
              size: 64,
              color: AppColors.textSecondary,
            ),
          );
        },
      );
    }

    // Otherwise use network image
    return CachedNetworkImage(
      imageUrl: imagePath,
      fit: BoxFit.contain,
      placeholder: (context, url) => Container(
        color: AppColors.surface,
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: AppColors.surface,
        child: const Icon(
          Icons.image_not_supported,
          size: 64,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildTrustBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_user,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trade safely with verified mediators',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textBright,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'This account has been verified by our technical support team.',
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

  Widget _buildAccountDetailsSection(BuyAccountModel account) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with cyan line
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 18,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Account Details',
                style: AppTextStyles.heading3.copyWith(
                  color: AppColors.textBright,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _formatAccountDetails(account),
            style: AppTextStyles.body.copyWith(
              color: AppColors.textPrimary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSellerInfoCard(BuyMediatorModel mediator) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Seller avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            child: mediator.avatar.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: CachedNetworkImage(
                      imageUrl: mediator.avatar,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.person,
                    color: AppColors.primary,
                    size: 28,
                  ),
          ),

          const SizedBox(width: 12),

          // Seller info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mediator.name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textBright,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.warning,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${mediator.rating} Rate',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.handshake,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${mediator.transactionsCount} Deals',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: () => _handleRequestToBuy(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.background,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Request to Buy',
                style: AppTextStyles.buttonText.copyWith(
                  color: AppColors.background,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleRequestToBuy(BuildContext context) {
    // Navigate directly to choose mediator screen
    context.push('/choose-mediator');
  }

  String _formatPriceInEGP(double priceInUSD) {
    // Convert USD to EGP (approximate rate: 1 USD = 48 EGP)
    final priceInEGP = priceInUSD * 48;
    return '${priceInEGP.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }

  String _formatAccountDetails(BuyAccountModel account) {
    // Build a detailed description based on account info
    final buffer = StringBuffer();

    // Main description
    buffer.writeln(account.description);
    buffer.writeln();

    // Add detailed info
    buffer.writeln('This is a ${account.game} account with ${account.rank} rank.');
    buffer.writeln('The seller has a rating of ${account.rating} with ${account.reviewsCount} reviews.');
    buffer.writeln();

    // Add features if available
    if (account.features.isNotEmpty) {
      buffer.writeln('Account Features:');
      for (final feature in account.features) {
        buffer.writeln('• ${feature.label}');
      }
      buffer.writeln();
    }

    // Add trust info
    buffer.writeln('✓ Verified Account');
    buffer.writeln('✓ Secure Transaction Guaranteed');
    buffer.writeln('✓ Full Access Provided');
    buffer.writeln('✓ 24/7 Support Available');
    buffer.writeln();

    // Add note about purchase process
    buffer.writeln('Purchase Process:');
    buffer.writeln('1. Select your preferred mediator');
    buffer.writeln('2. Complete payment through secure methods');
    buffer.writeln('3. Transfer account credentials securely');
    buffer.writeln('4. Confirm receipt and leave feedback');
    buffer.writeln();

    // Safety tips
    buffer.writeln('⚠️ Safety Tips:');
    buffer.writeln('• Always verify account before payment');
    buffer.writeln('• Keep transaction records');
    buffer.writeln('• Change password immediately after transfer');
    buffer.writeln('• Enable all security features');

    // Convert to list and limit to ~500 words
    final text = buffer.toString();
    final words = text.split(' ');

    if (words.length > 500) {
      return words.take(500).join(' ') + '...';
    }

    return text.trim();
  }
}
