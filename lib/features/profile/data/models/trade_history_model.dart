import 'dart:convert';

/// TradeHistoryModel - User's trade history item
///
/// Represents a completed trade transaction
class TradeHistoryModel {
  final String id;
  final String title;
  final double price;
  final String status;
  final DateTime timestamp;
  final String? game;

  const TradeHistoryModel({
    required this.id,
    required this.title,
    required this.price,
    required this.status,
    required this.timestamp,
    this.game,
  });

  /// Creates TradeHistoryModel from JSON map
  factory TradeHistoryModel.fromJson(Map<String, dynamic> json) {
    return TradeHistoryModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? 'pending',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
      game: json['game'] as String?,
    );
  }

  /// Creates TradeHistoryModel from JSON string
  factory TradeHistoryModel.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return TradeHistoryModel.fromJson(json);
  }

  /// Converts TradeHistoryModel to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
      'game': game,
    };
  }

  /// Converts TradeHistoryModel to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  /// Creates mock data matching Figma design
  static List<TradeHistoryModel> mockTradeHistory() {
    final now = DateTime.now();
    return [
      TradeHistoryModel(
        id: '1',
        title: 'PUBG Level 72',
        price: 120.0,
        status: 'completed',
        timestamp: now,
        game: 'PUBG',
      ),
      TradeHistoryModel(
        id: '2',
        title: 'Steam Account 15yr',
        price: 85.0,
        status: 'completed',
        timestamp: now.subtract(const Duration(days: 2)),
        game: 'Steam',
      ),
      TradeHistoryModel(
        id: '3',
        title: 'LoL Diamond Account',
        price: 195.0,
        status: 'completed',
        timestamp: now.subtract(const Duration(days: 5)),
        game: 'League of Legends',
      ),
      TradeHistoryModel(
        id: '4',
        title: 'Valorant Immortal',
        price: 320.0,
        status: 'pending',
        timestamp: now.subtract(const Duration(days: 7)),
        game: 'Valorant',
      ),
    ];
  }

  TradeHistoryModel copyWith({
    String? id,
    String? title,
    double? price,
    String? status,
    DateTime? timestamp,
    String? game,
  }) {
    return TradeHistoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      game: game ?? this.game,
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TradeHistoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          price == other.price &&
          status == other.status &&
          timestamp == other.timestamp &&
          game == other.game;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      price.hashCode ^
      status.hashCode ^
      timestamp.hashCode ^
      game.hashCode;
}
