import 'package:trusted_app/features/login/data/models/user_model.dart';
import 'package:dart_ipify/dart_ipify.dart';

import '../models/signup_request.dart';
import '../data_sources/signup_remote_data_source.dart';

abstract class SignupRepository {
  Future<UserModel> signup({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
  });
}

class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDataSource _remoteDataSource;

  SignupRepositoryImpl({
    required SignupRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<UserModel> signup({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      // Fetch IP Address
      String ipAddress = '';
      try {
        ipAddress = await Ipify.ipv4();
      } catch (e) {
        ipAddress = '0.0.0.0';
      }

      final response = await _remoteDataSource.signup(
        SignupRequest(
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          email: email,
          password: password,
          ipAddress: ipAddress,
          phoneNumber: phoneNumber,
        ),
      );

      if (response.user == null) {
        throw const SignupFailure('User data not found.');
      }

      return response.user!;
    } on SignupFailure {
      rethrow;
    } catch (e) {
      throw SignupFailure('An error occurred during registration.');
    }
  }
}

class SignupFailure implements Exception {
  final String message;

  const SignupFailure(this.message);

  @override
  String toString() => message;
}
