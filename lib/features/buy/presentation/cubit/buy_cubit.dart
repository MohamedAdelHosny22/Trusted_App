import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/buy_repository.dart';
import 'buy_state.dart';

/// Cubit for managing Buy screen state and operations
class BuyCubit extends Cubit<BuyState> {
  final BuyRepository repository;

  BuyCubit({
    required this.repository,
  }) : super(const BuyInitial());

  /// Load product by ID
  Future<void> loadProduct(String productId) async {
    emit(const BuyLoading());

    try {
      final product = await repository.getProduct(productId);
      emit(BuyLoaded(product: product));
    } catch (e) {
      emit(BuyError(message: 'Failed to load product: ${e.toString()}'));
    }
  }

  /// Increase quantity
  void increaseQuantity() {
    if (state is BuyLoaded) {
      final currentState = state as BuyLoaded;
      if (currentState.canIncreaseQuantity) {
        emit(currentState.copyWith(quantity: currentState.quantity + 1));
      }
    }
  }

  /// Decrease quantity
  void decreaseQuantity() {
    if (state is BuyLoaded) {
      final currentState = state as BuyLoaded;
      if (currentState.canDecreaseQuantity) {
        emit(currentState.copyWith(quantity: currentState.quantity - 1));
      }
    }
  }

  /// Set specific quantity
  void setQuantity(int quantity) {
    if (state is BuyLoaded) {
      final currentState = state as BuyLoaded;
      final validQuantity = quantity.clamp(1, currentState.product.stock ?? 99);
      emit(currentState.copyWith(quantity: validQuantity));
    }
  }

  /// Process purchase
  Future<void> purchase() async {
    if (state is! BuyLoaded) return;

    final currentState = state as BuyLoaded;
    emit(BuyPurchasing(
      product: currentState.product,
      quantity: currentState.quantity,
    ));

    try {
      final success = await repository.purchaseProduct(
        productId: currentState.product.id,
        quantity: currentState.quantity,
      );

      if (success) {
        emit(BuySuccess(
          message:
              'Successfully purchased ${currentState.quantity}x ${currentState.product.name}!',
        ));
      } else {
        emit(const BuyError(message: 'Purchase failed. Please try again.'));
      }
    } catch (e) {
      emit(BuyError(message: 'Purchase failed: ${e.toString()}'));
    }
  }

  /// Add to cart
  Future<void> addToCart() async {
    if (state is! BuyLoaded) return;

    final currentState = state as BuyLoaded;
    emit(const BuyLoading());

    try {
      final success = await repository.addToCart(
        productId: currentState.product.id,
        quantity: currentState.quantity,
      );

      if (success) {
        emit(BuyLoaded(
          product: currentState.product,
          quantity: currentState.quantity,
        ));
      } else {
        emit(const BuyError(message: 'Failed to add to cart. Please try again.'));
      }
    } catch (e) {
      emit(BuyError(message: 'Failed to add to cart: ${e.toString()}'));
    }
  }

  /// Reset to loaded state (for navigating away from success/error)
  void resetToLoaded() {
    if (state is BuyLoaded) {
      final currentState = state as BuyLoaded;
      emit(BuyLoaded(product: currentState.product));
    } else if (state is BuySuccess || state is BuyError) {
      emit(const BuyInitial());
    }
  }
}
