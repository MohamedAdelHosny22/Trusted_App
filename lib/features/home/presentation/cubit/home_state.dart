import 'package:equatable/equatable.dart';
import 'package:trusted_app/features/home/data/models/account_model.dart';
import 'package:trusted_app/features/home/data/models/category_model.dart';

class HomeState extends Equatable {
  final List<AccountModel> accounts;
  final List<CategoryModel> categories;
  final bool isLoading;

  const HomeState({
    this.accounts = const [],
    this.categories = const [],
    this.isLoading = false,
  });

  HomeState copyWith({
    List<AccountModel>? accounts,
    List<CategoryModel>? categories,
    bool? isLoading,
  }) {
    return HomeState(
      accounts: accounts ?? this.accounts,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [accounts, categories, isLoading];
}
