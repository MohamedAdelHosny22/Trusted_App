import 'package:equatable/equatable.dart';

/// SellListingState - State for sell listing flow
class SellListingState extends Equatable {
  final String? selectedGame;
  final String price;
  final String shortDescription;
  final String fullDetails;
  final List<String> images;
  final List<String> selectedMediators;
  final bool isSubmitting;

  const SellListingState({
    this.selectedGame,
    this.price = '',
    this.shortDescription = '',
    this.fullDetails = '',
    this.images = const [],
    this.selectedMediators = const [],
    this.isSubmitting = false,
  });

  /// Check if form is valid
  bool get isValid {
    return selectedGame != null &&
        price.isNotEmpty &&
        double.tryParse(price) != null &&
        double.parse(price) > 0 &&
        shortDescription.isNotEmpty &&
        fullDetails.isNotEmpty &&
        images.isNotEmpty;
  }

  SellListingState copyWith({
    String? selectedGame,
    String? price,
    String? shortDescription,
    String? fullDetails,
    List<String>? images,
    List<String>? selectedMediators,
    bool? isSubmitting,
  }) {
    return SellListingState(
      selectedGame: selectedGame ?? this.selectedGame,
      price: price ?? this.price,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDetails: fullDetails ?? this.fullDetails,
      images: images ?? this.images,
      selectedMediators: selectedMediators ?? this.selectedMediators,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  /// Convert to map for preview
  Map<String, dynamic> toMap() {
    return {
      'game': selectedGame,
      'price': price,
      'shortDescription': shortDescription,
      'fullDetails': fullDetails,
      'images': images,
      'selectedMediators': selectedMediators,
    };
  }

  @override
  List<Object?> get props => [
        selectedGame,
        price,
        shortDescription,
        fullDetails,
        images,
        selectedMediators,
        isSubmitting,
      ];
}
