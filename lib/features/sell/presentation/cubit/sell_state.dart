import 'package:equatable/equatable.dart';

/// Sell Screen States
abstract class SellState extends Equatable {
  const SellState();

  @override
  List<Object?> get props => [];
}

class SellInitial extends SellState {
  const SellInitial();
}

class SellUploading extends SellState {
  final double progress;

  const SellUploading({this.progress = 0});

  @override
  List<Object?> get props => [progress];
}

class SellSubmitting extends SellState {
  const SellSubmitting();
}

class SellSuccess extends SellState {
  final String listingId;

  const SellSuccess({required this.listingId});

  @override
  List<Object?> get props => [listingId];
}

class SellError extends SellState {
  final String message;

  const SellError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SellImageSelected extends SellState {
  final String imagePath;

  const SellImageSelected({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}
