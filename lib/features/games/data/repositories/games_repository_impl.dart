import '../models/game_model.dart';
import '../data_sources/games_remote_data_source.dart';
import 'games_repository.dart';

class GamesRepositoryImpl implements GamesRepository {
  final GamesRemoteDataSource remoteDataSource;

  const GamesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<GameModel>> getGames() async {
    return await remoteDataSource.getGames();
  }
}
