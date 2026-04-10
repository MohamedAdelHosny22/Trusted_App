import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/chat_model.dart';

/// ChatState
class ChatState extends Equatable {
  final List<ChatRoom> groupChats;
  final List<ChatRoom> privateChats;
  final bool isLoading;
  final String? errorMessage;

  const ChatState({
    this.groupChats = const [],
    this.privateChats = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ChatState copyWith({
    List<ChatRoom>? groupChats,
    List<ChatRoom>? privateChats,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ChatState(
      groupChats: groupChats ?? this.groupChats,
      privateChats: privateChats ?? this.privateChats,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [groupChats, privateChats, isLoading, errorMessage];
}

/// ChatCubit
class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatState()) {
    _loadMockChats();
  }

  void _loadMockChats() {
    // Mock group chats
    final groupChats = [
      ChatRoom(
        id: 'group1',
        name: 'PUBG Account Sale #1234',
        avatar: '',
        type: ChatType.group,
        participants: ['user1', 'mediator1', 'buyer1'],
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        unreadCount: 2,
        messages: [
          Message(
            id: 'm1',
            senderId: 'mediator1',
            senderName: 'Ahmed Mediator',
            senderAvatar: 'https://i.pravatar.cc/150?img=1',
            content: 'Payment received. Verifying account details.',
            type: MessageType.text,
            timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          ),
          Message(
            id: 'm2',
            senderId: 'buyer1',
            senderName: 'Mohamed Buyer',
            senderAvatar: 'https://i.pravatar.cc/150?img=3',
            content: 'Thanks for the quick response!',
            type: MessageType.text,
            timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
          ),
        ],
      ),
    ];

    // Mock private chats
    final privateChats = [
      ChatRoom(
        id: 'private1',
        name: 'Ahmed Mediator',
        avatar: 'https://i.pravatar.cc/150?img=1',
        type: ChatType.private,
        participants: ['user1', 'mediator1'],
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
        unreadCount: 0,
        messages: [
          Message(
            id: 'm3',
            senderId: 'mediator1',
            senderName: 'Ahmed Mediator',
            senderAvatar: 'https://i.pravatar.cc/150?img=1',
            content: 'Your listing has been approved!',
            type: MessageType.text,
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          ),
        ],
      ),
      ChatRoom(
        id: 'private2',
        name: 'Sarah Mediator',
        avatar: 'https://i.pravatar.cc/150?img=5',
        type: ChatType.private,
        participants: ['user1', 'mediator2'],
        lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
        unreadCount: 1,
        messages: [
          Message(
            id: 'm4',
            senderId: 'mediator2',
            senderName: 'Sarah Mediator',
            senderAvatar: 'https://i.pravatar.cc/150?img=5',
            content: 'How can I help you today?',
            type: MessageType.text,
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
          ),
        ],
      ),
    ];

    emit(state.copyWith(
      groupChats: groupChats,
      privateChats: privateChats,
    ));
  }

  void sendMessage(String chatId, String content) {
    final newMessage = Message(
      id: 'm${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'currentUser',
      senderName: 'You',
      senderAvatar: '',
      content: content,
      type: MessageType.text,
      timestamp: DateTime.now(),
    );

    // Update chat room
    final allChats = [...state.groupChats, ...state.privateChats];
    final chatIndex = allChats.indexWhere((c) => c.id == chatId);

    if (chatIndex != -1) {
      final chat = allChats[chatIndex];
      final updatedMessages = [...chat.messages, newMessage];
      final updatedChat = chat.copyWith(
        messages: updatedMessages,
        lastMessageTime: DateTime.now(),
      );

      if (chat.type == ChatType.group) {
        final updatedGroupChats = state.groupChats.map((c) {
          return c.id == chatId ? updatedChat : c;
        }).toList();
        emit(state.copyWith(groupChats: updatedGroupChats));
      } else {
        final updatedPrivateChats = state.privateChats.map((c) {
          return c.id == chatId ? updatedChat : c;
        }).toList();
        emit(state.copyWith(privateChats: updatedPrivateChats));
      }
    }
  }

  void markAsRead(String chatId) {
    final allChats = [...state.groupChats, ...state.privateChats];
    final chatIndex = allChats.indexWhere((c) => c.id == chatId);

    if (chatIndex != -1) {
      final chat = allChats[chatIndex];
      final updatedChat = chat.copyWith(unreadCount: 0);

      if (chat.type == ChatType.group) {
        final updatedGroupChats = state.groupChats.map((c) {
          return c.id == chatId ? updatedChat : c;
        }).toList();
        emit(state.copyWith(groupChats: updatedGroupChats));
      } else {
        final updatedPrivateChats = state.privateChats.map((c) {
          return c.id == chatId ? updatedChat : c;
        }).toList();
        emit(state.copyWith(privateChats: updatedPrivateChats));
      }
    }
  }
}
