import 'package:trusted_app/features/games/data/models/game_model.dart';

/// GamesState - State for games feature
///
/// Manages the list of games and loading state
class GamesState {
  final List<GameModel> games;
  final bool isLoading;
  final String? error;

  const GamesState({
    this.games = const [],
    this.isLoading = false,
    this.error,
  });

  GamesState copyWith({
    List<GameModel>? games,
    bool? isLoading,
    String? error,
  }) {
    return GamesState(
      games: games ?? this.games,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
