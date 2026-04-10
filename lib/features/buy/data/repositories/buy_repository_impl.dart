import '../datasources/buy_remote_data_source.dart';
import '../models/product_model.dart';
import 'buy_repository.dart';

/// Implementation of BuyRepository
class BuyRepositoryImpl implements BuyRepository {
  final BuyRemoteDataSource remoteDataSource;

  const BuyRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<ProductModel> getProduct(String productId) async {
    return await remoteDataSource.getProduct(productId);
  }

  @override
  Future<bool> purchaseProduct({
    required String productId,
    required int quantity,
  }) async {
    return await remoteDataSource.purchaseProduct(
      productId: productId,
      quantity: quantity,
    );
  }

  @override
  Future<bool> addToCart({
    required String productId,
    required int quantity,
  }) async {
    return await remoteDataSource.addToCart(
      productId: productId,
      quantity: quantity,
    );
  }
}
