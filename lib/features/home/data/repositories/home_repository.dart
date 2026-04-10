import 'package:trusted_app/features/home/data/models/account_model.dart';
import 'package:trusted_app/features/home/data/models/category_model.dart';
import '../data_sources/home_remote_data_source.dart';

abstract class HomeRepository {
  Future<List<AccountModel>> getAccounts();
  Future<List<CategoryModel>> getCategories();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<AccountModel>> getAccounts() async {
    return await remoteDataSource.getAccounts();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    return await remoteDataSource.getCategories();
  }
}
