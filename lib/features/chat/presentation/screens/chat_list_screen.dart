import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/chat_model.dart';
import '../cubit/chat_cubit.dart';
import '../widgets/chat_room_card.dart';
import 'chat_detail_screen.dart';

/// ChatListScreen - Main chat list with groups and private tabs
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(),
      child: const _ChatListContent(),
    );
  }
}

class _ChatListContent extends StatefulWidget {
  const _ChatListContent();

  @override
  State<_ChatListContent> createState() => _ChatListContentState();
}

class _ChatListContentState extends State<_ChatListContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return TabBarView(
            controller: _tabController,
            children: [
              // Groups tab
              _buildChatList(context, state.groupChats, ChatType.group),

              // Private tab
              _buildChatList(context, state.privateChats, ChatType.private),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Messages',
        style: AppTextStyles.heading3,
      ),
      bottom: TabBar(
        controller: _tabController,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        labelStyle: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppTextStyles.bodyLarge,
        tabs: const [
          Tab(text: 'Groups'),
          Tab(text: 'Private'),
        ],
      ),
    );
  }

  Widget _buildChatList(BuildContext context, List<ChatRoom> chats, ChatType type) {
    if (chats.isEmpty) {
      return _buildEmptyState(type);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.m),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ChatRoomCard(
          chat: chat,
          onTap: () => _openChat(context, chat),
        );
      },
    );
  }

  Widget _buildEmptyState(ChatType type) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            type == ChatType.group ? Icons.group_off : Icons.chat_bubble_outline,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.m),
          Text(
            type == ChatType.group ? 'No group chats' : 'No private chats',
            style: AppTextStyles.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            type == ChatType.group
                ? 'Your active deals will appear here'
                : 'Start a conversation with a mediator',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  void _openChat(BuildContext context, ChatRoom chat) {
    context.read<ChatCubit>().markAsRead(chat.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatDetailScreen(
          chatId: chat.id,
          chatType: chat.type,
        ),
      ),
    );
  }
}
