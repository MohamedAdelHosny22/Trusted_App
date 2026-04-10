import 'package:equatable/equatable.dart';

/// Message types
enum MessageType { text, image, system }

/// Message model
class Message extends Equatable {
  final String id;
  final String senderId;
  final String senderName;
  final String senderAvatar;
  final String content;
  final MessageType type;
  final DateTime timestamp;
  final bool isRead;

  const Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderAvatar,
    required this.content,
    required this.type,
    required this.timestamp,
    this.isRead = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      senderAvatar: json['senderAvatar'] as String,
      content: json['content'] as String,
      type: MessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MessageType.text,
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'senderAvatar': senderAvatar,
      'content': content,
      'type': type.name,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
    };
  }

  Message copyWith({
    String? id,
    String? senderId,
    String? senderName,
    String? senderAvatar,
    String? content,
    MessageType? type,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      content: content ?? this.content,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [id, senderId, content, timestamp, isRead];
}

/// Chat types
enum ChatType { group, private }

/// ChatRoom model
class ChatRoom extends Equatable {
  final String id;
  final String name;
  final String? avatar;
  final ChatType type;
  final List<Message> messages;
  final List<String> participants;
  final DateTime lastMessageTime;
  final int unreadCount;

  const ChatRoom({
    required this.id,
    required this.name,
    this.avatar,
    required this.type,
    required this.messages,
    required this.participants,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });

  Message? get lastMessage => messages.isNotEmpty ? messages.last : null;

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      type: ChatType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ChatType.private,
      ),
      messages: (json['messages'] as List)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      participants: (json['participants'] as List).cast<String>(),
      lastMessageTime: DateTime.parse(json['lastMessageTime'] as String),
      unreadCount: json['unreadCount'] as int? ?? 0,
    );
  }

  ChatRoom copyWith({
    String? id,
    String? name,
    String? avatar,
    ChatType? type,
    List<Message>? messages,
    List<String>? participants,
    DateTime? lastMessageTime,
    int? unreadCount,
  }) {
    return ChatRoom(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      type: type ?? this.type,
      messages: messages ?? this.messages,
      participants: participants ?? this.participants,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [id, name, unreadCount];
}
