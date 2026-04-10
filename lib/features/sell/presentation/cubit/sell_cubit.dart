import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'sell_state.dart';

/// SellCubit - State management for Sell Screen
class SellCubit extends Cubit<SellState> {
  SellCubit() : super(const SellInitial());

  final ImagePicker _imagePicker = ImagePicker();

  // Form data
  final List<String> _images = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String? _selectedCategory;

  // Getters
  List<String> get images => List.unmodifiable(_images);
  String? get selectedCategory => _selectedCategory;
  bool get hasMainImage => _images.isNotEmpty;
  bool get canSubmit => _validateForm();

  // Validation
  bool _validateForm() {
    if (_images.isEmpty) return false;
    if (titleController.text.trim().length < 3) return false;
    if (descriptionController.text.trim().length < 10) return false;
    if (priceController.text.trim().isEmpty) return false;
    if (_selectedCategory == null) return false;
    return true;
  }

  // Image handling
  Future<void> pickMainImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        _images.clear();
        _images.add(image.path);
        emit(SellImageSelected(imagePath: image.path));
      }
    } catch (e) {
      emit(SellError(message: 'Failed to pick image: $e'));
    }
  }

  Future<void> pickAdditionalImage() async {
    if (_images.length >= 5) {
      emit(const SellError(message: 'Maximum 5 images allowed'));
      return;
    }

    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        _images.add(image.path);
        emit(SellImageSelected(imagePath: image.path));
      }
    } catch (e) {
      emit(SellError(message: 'Failed to pick image: $e'));
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < _images.length) {
      _images.removeAt(index);
      emit(const SellInitial());
    }
  }

  // Category selection
  void selectCategory(String category) {
    _selectedCategory = category;
    emit(const SellInitial());
  }

  // Trigger validation update without changing state
  void updateValidation() {
    emit(state);
  }

  // Form submission
  Future<void> submitListing() async {
    if (!canSubmit) {
      emit(const SellError(message: 'Please fill all required fields'));
      return;
    }

    emit(const SellSubmitting());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Success
      final listingId = 'listing_${DateTime.now().millisecondsSinceEpoch}';
      emit(SellSuccess(listingId: listingId));
    } catch (e) {
      emit(SellError(message: 'Failed to create listing: $e'));
    }
  }

  // Clear error state
  void clearError() {
    if (state is SellError) {
      emit(const SellInitial());
    }
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    return super.close();
  }
}
