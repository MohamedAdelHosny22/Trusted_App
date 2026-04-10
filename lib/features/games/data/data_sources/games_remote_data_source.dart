import 'package:flutter/material.dart';
import '../models/game_model.dart';

/// GamesRemoteDataSource - Mock data source for games
///
/// Provides mock game data for development
/// In production, this would fetch from an actual API
class GamesRemoteDataSource {
  const GamesRemoteDataSource();

  /// Fetch mock games
  Future<List<GameModel>> getGames() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      GameModel(
        id: '1',
        name: 'PUBG',
        icon: Icons.public,
        imageUrl: "assets/images/26a8534fb2d7063e6157af9513b219d9.jpg",
      ),
      GameModel(
        id: '2',
        name: 'Free Fire',
        icon: Icons.local_fire_department,
        imageUrl: "assets/images/377aab6c8d17efa8c86ca94cf4e6cc0d.jpg",
      ),
      GameModel(
        id: '3',
        name: 'Call of Duty',
        icon: Icons.gps_fixed,
        imageUrl: "assets/images/377aab6c8d17efa8c86ca94cf4e6cc0d.jpg",
      ),
      GameModel(
        id: '4',
        name: 'Fortnite',
        icon: Icons.location_on,
      ),
      GameModel(
        id: '5',
        name: 'Valorant',
        icon: Icons.videogame_asset,
      ),
      GameModel(
        id: '6',
        name: 'CoC',
        icon: Icons.sports_esports,
      ),
      GameModel(
        id: '7',
        name: 'Mobile Legends',
        icon: Icons.shield,
      ),
      GameModel(
        id: '8',
        name: 'Garena Free Fire',
        icon: Icons.whatshot,
      ),
      GameModel(
        id: '9',
        name: 'Clash Royale',
        icon: Icons.emoji_events,
      ),
      GameModel(
        id: '10',
        name: 'Brawl Stars',
        icon: Icons.stars,
      ),
      GameModel(
        id: '11',
        name: 'PUBG Mobile',
        icon: Icons.phone_android,
      ),
      GameModel(
        id: '12',
        name: 'Call of Duty Mobile',
        icon: Icons.phone_iphone,
      ),
    ];
  }
}
