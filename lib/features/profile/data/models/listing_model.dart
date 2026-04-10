import 'dart:convert';

/// ListingModel - User's listing for marketplace
///
/// Represents a single listing item that user has posted for sale
class ListingModel {
  final String id;
  final String title;
  final double price;
  final String? thumbnailUrl;
  final String? game;
  final String status;

  const ListingModel({
    required this.id,
    required this.title,
    required this.price,
    this.thumbnailUrl,
    this.game,
    this.status = 'active',
  });

  /// Creates ListingModel from JSON map
  factory ListingModel.fromJson(Map<String, dynamic> json) {
    return ListingModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      game: json['game'] as String?,
      status: json['status'] as String? ?? 'active',
    );
  }

  /// Creates ListingModel from JSON string
  factory ListingModel.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return ListingModel.fromJson(json);
  }

  /// Converts ListingModel to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'thumbnailUrl': thumbnailUrl,
      'game': game,
      'status': status,
    };
  }

  /// Converts ListingModel to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  /// Creates mock data for Profile section (first 3-4 items)
  static List<ListingModel> mockListings() {
    return [
      ListingModel(
        id: '1',
        title: 'Valorant Radiant',
        price: 450.0,
        game: 'Valorant',
        thumbnailUrl: 'assets/accounts/account_1.jpeg',
      ),
      ListingModel(
        id: '2',
        title: 'Genshin AR 60',
        price: 220.0,
        game: 'Genshin Impact',
        thumbnailUrl: 'assets/accounts/account_2.jpeg',
      ),
      ListingModel(
        id: '3',
        title: 'CSGO Prime',
        price: 85.0,
        game: 'CS:GO',
        thumbnailUrl: 'assets/accounts/account_3.jpeg',
      ),
      ListingModel(
        id: '4',
        title: 'Fortnite 200 Wins',
        price: 120.0,
        game: 'Fortnite',
        thumbnailUrl: 'assets/accounts/account_4.jpeg',
      ),
    ];
  }

  /// Creates mock data for View All screen (extended listings)
  static List<ListingModel> mockListingsExtended() {
    return [
      // Original 4
      ListingModel(
        id: '1',
        title: 'Valorant Radiant',
        price: 450.0,
        game: 'Valorant',
        thumbnailUrl: 'assets/accounts/account_1.jpeg',
      ),
      ListingModel(
        id: '2',
        title: 'Genshin AR 60',
        price: 220.0,
        game: 'Genshin Impact',
        thumbnailUrl: 'assets/accounts/account_2.jpeg',
      ),
      ListingModel(
        id: '3',
        title: 'CSGO Prime',
        price: 85.0,
        game: 'CS:GO',
        thumbnailUrl: 'assets/accounts/account_3.jpeg',
      ),
      ListingModel(
        id: '4',
        title: 'Fortnite 200 Wins',
        price: 120.0,
        game: 'Fortnite',
        thumbnailUrl: 'assets/accounts/account_4.jpeg',
      ),
      // Additional listings for View All
      ListingModel(
        id: '5',
        title: 'Valorant Immortal',
        price: 320.0,
        game: 'Valorant',
        thumbnailUrl: 'assets/accounts/account_5.jpeg',
      ),
      ListingModel(
        id: '6',
        title: 'Genshin AR 55',
        price: 180.0,
        game: 'Genshin Impact',
        thumbnailUrl: 'assets/accounts/account_1.jpeg', // Reuse images cyclically
      ),
      ListingModel(
        id: '7',
        title: 'CSGO Global Elite',
        price: 150.0,
        game: 'CS:GO',
        thumbnailUrl: 'assets/accounts/account_2.jpeg',
      ),
      ListingModel(
        id: '8',
        title: 'Fortnite OG Skins',
        price: 200.0,
        game: 'Fortnite',
        thumbnailUrl: 'assets/accounts/account_3.jpeg',
      ),
      ListingModel(
        id: '9',
        title: 'LOL Challenger',
        price: 280.0,
        game: 'League of Legends',
        thumbnailUrl: 'assets/accounts/account_4.jpeg',
      ),
      ListingModel(
        id: '10',
        title: 'Apex Predator',
        price: 195.0,
        game: 'Apex Legends',
        thumbnailUrl: 'assets/accounts/account_5.jpeg',
      ),
      ListingModel(
        id: '11',
        title: 'Overwatch GM',
        price: 110.0,
        game: 'Overwatch',
        thumbnailUrl: 'assets/accounts/account_1.jpeg', // Reuse cyclically
      ),
      ListingModel(
        id: '12',
        title: 'Rainbow Six Diamond',
        price: 130.0,
        game: 'Rainbow Six Siege',
        thumbnailUrl: 'assets/accounts/account_2.jpeg',
      ),
    ];
  }

  ListingModel copyWith({
    String? id,
    String? title,
    double? price,
    String? thumbnailUrl,
    String? game,
    String? status,
  }) {
    return ListingModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      game: game ?? this.game,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListingModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          price == other.price &&
          thumbnailUrl == other.thumbnailUrl &&
          game == other.game &&
          status == other.status;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      price.hashCode ^
      thumbnailUrl.hashCode ^
      game.hashCode ^
      status.hashCode;
}
