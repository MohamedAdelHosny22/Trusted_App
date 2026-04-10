import 'package:flutter/material.dart';

/// Account model for marketplace items
class AccountModel {
  final String id;
  final String title;
  final double price;
  final String game;
  final String imageUrl;
  final String categoryId;
  final double rating;
  final int reviews;
  final bool isPremium;
  final String? tier;

  const AccountModel({
    required this.id,
    required this.title,
    required this.price,
    required this.game,
    required this.imageUrl,
    required this.categoryId,
    this.rating = 4.5,
    this.reviews = 0,
    this.isPremium = false,
    this.tier,
  });

  /// Get tier color based on account tier
  static String getTierColor(String? tier) {
    switch (tier?.toLowerCase()) {
      case 'gold':
        return '#FFD700';
      case 'elite':
        return '#00EEFF';
      default:
        return '#A0A0A0';
    }
  }

  /// Get color from hex string
  static Color getColorFromHex(String hexColor) {
    return Color(int.parse(hexColor.replaceAll('#', '0xFF')));
  }
}
