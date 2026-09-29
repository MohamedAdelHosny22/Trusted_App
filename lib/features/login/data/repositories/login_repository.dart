import 'package:dart_ipify/dart_ipify.dart';
import '../models/user_model.dart';
import '../models/login_request.dart';
import '../data_sources/login_remote_data_source.dart';

abstract class LoginRepository {
  Future<UserModel> login({
    required String email,
    required String password,
  });
}

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _remoteDataSource;

  LoginRepositoryImpl({
    required LoginRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      // Fetch IP Address
      String ipAddress = '';
      try {
        ipAddress = await Ipify.ipv4();
      } catch (e) {
        // Fallback or handle IP fetch error if necessary
        ipAddress = '0.0.0.0';
      }

      // Call remote data source
      final response = await _remoteDataSource.login(
        LoginRequest(
          email: email,
          password: password,
          ipAddress: ipAddress,
        ),
      );

      if (response.user == null) {
        throw const LoginFailure('User data not found.');
      }

      // Extract user data from response
      // In production, you might want to store tokens here
      return response.user!;
    } on LoginFailure {
      rethrow;
    } catch (e) {
      throw LoginFailure('An error occurred during login.');
    }
  }
}

class LoginFailure implements Exception {
  final String message;

  const LoginFailure(this.message);

  @override
  String toString() => message;
}
