import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/data_sources/games_remote_data_source.dart';
import '../../data/repositories/games_repository_impl.dart';
import '../cubit/games_cubit.dart';
import '../cubit/games_state.dart';
import '../widgets/games_grid.dart';

/// GamesScreen - Screen displaying all games
///
/// Features:
/// - App bar with back button and title
/// - Responsive grid of games
/// - Loading and error states
class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _createGamesCubit(),
      child: const _GamesContent(),
    );
  }

  GamesCubit _createGamesCubit() {
    final repository = GamesRepositoryImpl(
      remoteDataSource: const GamesRemoteDataSource(),
    );
    return GamesCubit(repository: repository)..loadGames();
  }
}

class _GamesContent extends StatefulWidget {
  const _GamesContent();

  @override
  State<_GamesContent> createState() => _GamesContentState();
}

class _GamesContentState extends State<_GamesContent> {
  @override
  void initState() {
    super.initState();
    // Load games when screen initializes
    context.read<GamesCubit>().loadGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: BlocBuilder<GamesCubit, GamesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: AppSpacing.m),
                  Text(
                    'Error loading games',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.s),
                  Text(
                    state.error!,
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state.games.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.videogame_asset_outlined,
                    size: 48,
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: AppSpacing.m),
                  Text(
                    'No Games Found',
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: AppSpacing.s),
                  Text(
                    'Check back later for new games',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            );
          }

          return GamesGrid(
            games: state.games,
            onGameTap: (game) {
              // TODO: Navigate to game details or filter accounts
            },
          );
        },
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
        onPressed: () => context.pop(),
      ),
      title: Text(
        'All Games',
        style: AppTextStyles.heading2,
      ),
      centerTitle: true,
    );
  }
}
