import 'package:flutter/material.dart';

/// GameModel - Game data model
///
/// Represents a game in the marketplace
class GameModel {
  final String id;
  final String name;
  final IconData icon;
  final String? imageUrl;

  const GameModel({
    required this.id,
    required this.name,
    required this.icon,
    this.imageUrl,
  });

  /// Convert to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon.toString(),
      'imageUrl': imageUrl,
    };
  }

  /// Create from map
  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      id: map['id'] as String,
      name: map['name'] as String,
      icon: map['icon'] as IconData,
      imageUrl: map['imageUrl'] as String?,
    );
  }
}
