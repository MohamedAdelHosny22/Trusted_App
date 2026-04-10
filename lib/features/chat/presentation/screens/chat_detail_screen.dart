import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/chat_model.dart';
import '../cubit/chat_cubit.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input_field.dart';

/// ChatDetailScreen - Individual chat/conversation screen
class ChatDetailScreen extends StatefulWidget {
  final String chatId;
  final ChatType chatType;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
    required this.chatType,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late final ChatCubit _cubit;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = ChatCubit();
  }

  @override
  void dispose() {
    _cubit.close();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(context),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            final chats = widget.chatType == ChatType.group
                ? state.groupChats
                : state.privateChats;
            final chat = chats.firstWhere(
              (c) => c.id == widget.chatId,
              orElse: () => ChatRoom(
                id: '',
                name: 'Chat',
                type: widget.chatType,
                messages: [],
                participants: [],
                lastMessageTime: DateTime.now(),
              ),
            );

            return Column(
              children: [
                // Messages list
                Expanded(
                  child: _buildMessagesList(chat),
                ),

                // Input field
                _buildInputArea(context),
              ],
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.textPrimary,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          final chats = widget.chatType == ChatType.group
              ? state.groupChats
              : state.privateChats;
          final chat = chats.firstWhere(
            (c) => c.id == widget.chatId,
            orElse: () => ChatRoom(
              id: '',
              name: 'Chat',
              type: widget.chatType,
              messages: [],
              participants: [],
              lastMessageTime: DateTime.now(),
            ),
          );

          return _buildTitle(chat);
        },
      ),
    );
  }

  Widget _buildTitle(ChatRoom chat) {
    if (widget.chatType == ChatType.group) {
      return Column(
        children: [
          Text(
            chat.name,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${chat.participants.length} participants',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          if (chat.avatar != null && chat.avatar!.isNotEmpty)
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(chat.avatar!),
            )
          else
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.surface,
              child: Text(
                chat.name[0].toUpperCase(),
                style: AppTextStyles.bodyLarge,
              ),
            ),
          const SizedBox(width: AppSpacing.s),
          Text(
            chat.name,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildMessagesList(ChatRoom chat) {
    if (chat.messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.m),
            Text(
              'No messages yet',
              style: AppTextStyles.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.s),
            Text(
              'Start the conversation',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppSpacing.m),
      itemCount: chat.messages.length,
      itemBuilder: (context, index) {
        final message = chat.messages[index];
        final isCurrentUser = message.senderId == 'currentUser';
        return MessageBubble(
          message: message,
          isCurrentUser: isCurrentUser,
        );
      },
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Attach button
            IconButton(
              icon: const Icon(
                Icons.attach_file,
                color: AppColors.textSecondary,
              ),
              onPressed: () {},
            ),

            // Input field
            Expanded(
              child: ChatInputField(
                controller: _messageController,
                onSubmitted: (text) => _sendMessage(context),
              ),
            ),

            // Send button
            IconButton(
              icon: const Icon(
                Icons.send,
                color: AppColors.primary,
              ),
              onPressed: () => _sendMessage(context),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    context.read<ChatCubit>().sendMessage(widget.chatId, text);
    _messageController.clear();

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
