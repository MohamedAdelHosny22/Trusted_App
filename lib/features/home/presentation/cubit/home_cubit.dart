import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';
import '../../data/repositories/home_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit(this.repository) : super(const HomeState()) {
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    emit(state.copyWith(isLoading: true));

    try {
      final accounts = await repository.getAccounts();
      final categories = await repository.getCategories();

      emit(state.copyWith(
        accounts: accounts,
        categories: categories,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      debugPrint('Error loading home data: $e');
    }
  }

  void searchAccounts(String query) {
    if (query.isEmpty) {
      loadHomeData();
      return;
    }

    final filtered = state.accounts
        .where((account) =>
            account.title.toLowerCase().contains(query.toLowerCase()) ||
            account.game.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(state.copyWith(accounts: filtered));
  }

  void filterByCategory(String categoryId) {
    if (categoryId.isEmpty) {
      loadHomeData();
      return;
    }

    final filtered = state.accounts
        .where((account) => account.categoryId == categoryId)
        .toList();

    emit(state.copyWith(accounts: filtered));
  }
}
