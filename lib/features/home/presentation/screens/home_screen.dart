import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trusted_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:trusted_app/features/home/presentation/cubit/home_state.dart';
import 'package:trusted_app/features/home/presentation/widgets/home_categories_section.dart';
import 'package:trusted_app/features/home/presentation/widgets/home_faq_section.dart';
import 'package:trusted_app/features/home/presentation/widgets/home_featured_section.dart';
import 'package:trusted_app/features/home/presentation/widgets/home_header.dart';
import 'package:trusted_app/features/home/presentation/widgets/home_promo_section.dart';
import 'package:trusted_app/features/home/presentation/widgets/home_search_section.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/data_sources/home_remote_data_source.dart';
import '../../data/repositories/home_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🏠 HomeScreen: Building HomeScreen widget');
    return BlocProvider(
      create: (_) => _createHomeCubit(),
      child: const _HomeContent(),
    );
  }

  HomeCubit _createHomeCubit() {
    debugPrint('🏠 HomeScreen: Creating HomeCubit');
    final remoteDataSource = const HomeRemoteDataSourceImpl();
    final repository = HomeRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );
    return HomeCubit(repository);
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    debugPrint('🏠 _HomeContent: Building _HomeContent widget');
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            debugPrint(
              '🏠 _HomeContent: State - loading: ${state.isLoading}, accounts: ${state.accounts.length}, categories: ${state.categories.length}',
            );
            return Column(
              children: [
                // Fixed header and content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HomeHeader(),
                        const SizedBox(height: AppSpacing.m),
                        const HomeSearchSection(),
                        const SizedBox(height: AppSpacing.m),
                        AppBanner.secure(),
                        const SizedBox(height: AppSpacing.l),
                        const HomePromoSection(),
                        const SizedBox(height: AppSpacing.xl),
                        const HomeCategoriesSection(),
                        const SizedBox(height: AppSpacing.xl),
                        HomeFeaturedSection(state: state),
                        const SizedBox(height: AppSpacing.xl),
                        const HomeFaqSection(),
                        const SizedBox(height: AppSpacing.xl + 80),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
