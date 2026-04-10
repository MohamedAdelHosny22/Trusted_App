import '../../data/models/product_model.dart';

/// Abstract repository for buy operations
abstract class BuyRepository {
  /// Fetch product details by ID
  Future<ProductModel> getProduct(String productId);

  /// Process purchase
  Future<bool> purchaseProduct({
    required String productId,
    required int quantity,
  });

  /// Add to cart
  Future<bool> addToCart({
    required String productId,
    required int quantity,
  });
}
