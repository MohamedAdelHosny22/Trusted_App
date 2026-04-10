import 'package:flutter_bloc/flutter_bloc.dart';
import 'games_state.dart';
import '../../data/repositories/games_repository.dart';

/// GamesCubit - Business logic for games feature
///
/// Responsibilities:
/// - Load games from repository
/// - Manage loading and error states
class GamesCubit extends Cubit<GamesState> {
  final GamesRepository repository;

  GamesCubit({required this.repository}) : super(const GamesState());

  /// Load games from repository
  Future<void> loadGames() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final games = await repository.getGames();
      emit(state.copyWith(
        games: games,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}
