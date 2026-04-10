import 'package:flutter_bloc/flutter_bloc.dart';
import 'sell_listing_state.dart';

/// SellListingCubit - Manages sell listing form state
class SellListingCubit extends Cubit<SellListingState> {
  SellListingCubit() : super(const SellListingState());

  /// Update selected game
  void updateGame(String game) {
    emit(state.copyWith(selectedGame: game));
  }

  /// Update price
  void updatePrice(String price) {
    emit(state.copyWith(price: price));
  }

  /// Update short description
  void updateShortDescription(String description) {
    emit(state.copyWith(shortDescription: description));
  }

  /// Update full details
  void updateFullDetails(String details) {
    emit(state.copyWith(fullDetails: details));
  }

  /// Add image
  void addImage(String imagePath) {
    if (state.images.length < 3) {
      final newImages = [...state.images, imagePath];
      emit(state.copyWith(images: newImages));
    }
  }

  /// Remove image
  void removeImage(int index) {
    if (index >= 0 && index < state.images.length) {
      final newImages = List<String>.from(state.images)..removeAt(index);
      emit(state.copyWith(images: newImages));
    }
  }

  /// Toggle mediator selection
  void toggleMediator(String mediatorId) {
    final current = state.selectedMediators;
    List<String> updated;

    if (current.contains(mediatorId)) {
      updated = List<String>.from(current)..remove(mediatorId);
    } else {
      updated = List<String>.from(current)..add(mediatorId);
    }

    emit(state.copyWith(selectedMediators: updated));
  }

  /// Submit listing
  void submitListing() {
    emit(state.copyWith(isSubmitting: true));
    // TODO: Send to backend
    emit(state.copyWith(isSubmitting: false));
  }

  /// Reset form
  void reset() {
    emit(const SellListingState());
  }
}
