import 'package:equatable/equatable.dart';

/// ProductModel - Represents a purchasable product
///
/// Used in the Buy screen to display product details
class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String? category;
  final String? platform;
  final String? region;
  final int? stock;
  final double? rating;
  final int? reviewCount;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.category,
    this.platform,
    this.region,
    this.stock,
    this.rating,
    this.reviewCount,
  });

  /// Format price as currency string
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  /// Check if product is in stock
  bool get isInStock => stock == null || stock! > 0;

  /// Get rating display text
  String? get ratingDisplay {
    if (rating == null) return null;
    final count = reviewCount ?? 0;
    return count > 0 ? '$rating ($count reviews)' : null;
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    String? platform,
    String? region,
    int? stock,
    double? rating,
    int? reviewCount,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      platform: platform ?? this.platform,
      region: region ?? this.region,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        category,
        platform,
        region,
        stock,
        rating,
        reviewCount,
      ];
}
