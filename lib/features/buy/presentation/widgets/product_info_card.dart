import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/product_model.dart';

/// ProductImageSection - Displays product image
class ProductImageSection extends StatelessWidget {
  final String imageUrl;
  final String productName;

  const ProductImageSection({
    super.key,
    required this.imageUrl,
    required this.productName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A42),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: const Color(0xFF1E3A42),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                backgroundColor: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: const Color(0xFF1E3A42),
            child: const Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                size: 48,
                color: Color(0xFF546E7A),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ProductInfoCard - Displays product details matching Figma
class ProductInfoCard extends StatelessWidget {
  final ProductModel product;

  const ProductInfoCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row with rating badge
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBright,
                  height: 1.4,
                ),
              ),
            ),
            if (product.rating != null) _buildRatingBadge(),
          ],
        ),
        const SizedBox(height: 12),

        // Category and platform tags
        if (product.category != null || product.platform != null)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (product.category != null)
                _buildTag(product.category!),
              if (product.platform != null)
                _buildTag(product.platform!),
            ],
          ),
        const SizedBox(height: 16),

        // Price and stock row
        Row(
          children: [
            Text(
              product.formattedPrice,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.priceGreen,
                height: 1.2,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'In Stock',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.success,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingBadge() {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 14,
            color: AppColors.warning,
          ),
          const SizedBox(width: 4),
          Text(
            product.rating!.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.warning,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A42),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF334155),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF94A3B8),
          height: 1.3,
        ),
      ),
    );
  }
}

/// ProductDescriptionSection - Displays product description
class ProductDescriptionSection extends StatelessWidget {
  final String description;

  const ProductDescriptionSection({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textBright,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
