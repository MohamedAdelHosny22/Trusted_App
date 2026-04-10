import 'package:trusted_app/features/home/data/models/account_model.dart';
import 'package:trusted_app/features/home/data/models/category_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<AccountModel>> getAccounts();
  Future<List<CategoryModel>> getCategories();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl();

  @override
  Future<List<AccountModel>> getAccounts() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data for accounts with real asset images
    return [
      const AccountModel(
        id: '1',
        title: 'Th10 LVL 220 Max',
        price: 299.99,
        game: 'Clash of Clans',
        imageUrl: 'assets/accounts/account_1.jpeg',
        categoryId: 'coc',
        rating: 4.8,
        reviews: 124,
        isPremium: true,
        tier: 'elite',
      ),
      const AccountModel(
        id: '2',
        title: 'LVL 150 BH10',
        price: 149.99,
        game: 'Clash of Clans',
        imageUrl: 'assets/accounts/account_2.jpeg',
        categoryId: 'coc',
        rating: 4.5,
        reviews: 89,
        isPremium: false,
      ),
      const AccountModel(
        id: '3',
        title: 'Grandmaster Ready',
        price: 499.99,
        game: 'Mobile Legends',
        imageUrl: 'assets/accounts/account_3.jpeg',
        categoryId: 'ml',
        rating: 4.9,
        reviews: 256,
        isPremium: true,
        tier: 'gold',
      ),
      const AccountModel(
        id: '4',
        title: 'Epic Account All Skins',
        price: 199.99,
        game: 'Fortnite',
        imageUrl: 'assets/accounts/account_4.jpeg',
        categoryId: 'fortnite',
        rating: 4.7,
        reviews: 78,
        isPremium: false,
      ),
      const AccountModel(
        id: '5',
        title: 'Ascendant Account',
        price: 349.99,
        game: 'Valorant',
        imageUrl: 'assets/accounts/account_5.jpeg',
        categoryId: 'valorant',
        rating: 4.6,
        reviews: 145,
        isPremium: true,
        tier: 'elite',
      ),
      const AccountModel(
        id: '6',
        title: 'LVL 100 Starter',
        price: 49.99,
        game: 'PUBG Mobile',
        imageUrl: 'assets/accounts/account_1.jpeg', // Reuse cyclically
        categoryId: 'pubg',
        rating: 4.3,
        reviews: 52,
        isPremium: false,
      ),
    ];
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Mock data for categories
    return [
      const CategoryModel(
        id: 'all',
        name: 'All',
        icon: '🎮',
        isSelected: true,

      ),
      const CategoryModel(
        id: 'coc',
        name: 'CoC',
        icon: '⚔️',
      ),
      const CategoryModel(
        id: 'ml',
        name: 'MLBB',
        icon: '🏆',
      ),
      const CategoryModel(
        id: 'fortnite',
        name: 'Fortnite',
        icon: '🎯',
      ),
      const CategoryModel(
        id: 'valorant',
        name: 'Valorant',
        icon: '🔫',
      ),
      const CategoryModel(
        id: 'pubg',
        name: 'PUBG',
        icon: '🪖',
      ),
    ];
  }
}
