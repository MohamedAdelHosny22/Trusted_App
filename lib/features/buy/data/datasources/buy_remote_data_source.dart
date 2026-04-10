import '../models/product_model.dart';

/// Remote data source for buy operations
class BuyRemoteDataSource {
  const BuyRemoteDataSource();

  /// Fetch product details (mock implementation)
  Future<ProductModel> getProduct(String productId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock product data
    return ProductModel(
      id: productId,
      name: 'Valorant Points - 5200 Points',
      description:
          'Get 5200 Valorant Points to customize your agents with premium skins, melee weapons, and more. Points are added to your account instantly after purchase.',
      price: 49.99,
      imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800',
      category: 'Game Currency',
      platform: 'Riot Games',
      region: 'NA',
      stock: 999,
      rating: 4.8,
      reviewCount: 2547,
    );
  }

  /// Process purchase (mock implementation)
  Future<bool> purchaseProduct({
    required String productId,
    required int quantity,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock success
    return true;
  }

  /// Add to cart (mock implementation)
  Future<bool> addToCart({
    required String productId,
    required int quantity,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock success
    return true;
  }
}
