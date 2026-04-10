import '../models/game_model.dart';

abstract class GamesRepository {
  Future<List<GameModel>> getGames();
}
