import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';

/// Base state for BuyCubit
abstract class BuyState extends Equatable {
  const BuyState();

  @override
  List<Object?> get props => [];
}

/// Initial state - no data loaded yet
class BuyInitial extends BuyState {
  const BuyInitial();
}

/// Loading state - fetching product data
class BuyLoading extends BuyState {
  const BuyLoading();
}

/// Loaded state - product data available
class BuyLoaded extends BuyState {
  final ProductModel product;
  final int quantity;

  const BuyLoaded({
    required this.product,
    this.quantity = 1,
  });

  /// Calculate total price
  double get totalPrice => product.price * quantity;

  /// Check if max quantity reached
  bool get canIncreaseQuantity =>
      product.stock == null || quantity < product.stock!;

  /// Check if min quantity reached
  bool get canDecreaseQuantity => quantity > 1;

  BuyLoaded copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return BuyLoaded(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}

/// Purchasing state - processing purchase
class BuyPurchasing extends BuyState {
  final ProductModel product;
  final int quantity;

  const BuyPurchasing({
    required this.product,
    required this.quantity,
  });

  @override
  List<Object?> get props => [product, quantity];
}

/// Success state - purchase completed
class BuySuccess extends BuyState {
  final String message;

  const BuySuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Error state - something went wrong
class BuyError extends BuyState {
  final String message;

  const BuyError({required this.message});

  @override
  List<Object?> get props => [message];
}
