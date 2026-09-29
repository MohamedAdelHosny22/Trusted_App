import '../models/login_request.dart';
import '../models/login_response.dart';
import 'package:dio/dio.dart';
import '../repositories/login_repository.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Dio _dio;
  final String baseUrl;

  LoginRemoteDataSourceImpl({
    Dio? dio,
  })  : _dio = dio ?? Dio(),
        baseUrl = 'http://trust.runasp.net/api';

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '$baseUrl/Auth/login',
        data: request.toJson(),
      );

      final loginResponse = LoginResponse.fromJson(response.data);
      if (!loginResponse.isSuccess) {
        throw LoginFailure(loginResponse.enRes ?? 'Login failed');
      }
      return loginResponse;
      
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == 400) {
        final data = e.response?.data;
        if (data is Map<String, dynamic> && data['errors'] != null) {
          final errors = data['errors'] as Map<String, dynamic>;
          final firstErrorList = errors.values.first;
          if (firstErrorList is List && firstErrorList.isNotEmpty) {
            throw LoginFailure(firstErrorList.first.toString());
          }
        }
        throw const LoginFailure('Invalid credentials provided.');
      } else if (e.response?.statusCode == 401) {
        throw const LoginFailure('Incorrect email or password.');
      } else if (e.response?.statusCode == 500) {
        throw const LoginFailure('Server error. Please try again later.');
      } else {
        throw const LoginFailure('Connection error. Please check your internet connection.');
      }
    } catch (e) {
      if (e is LoginFailure) rethrow;
      throw const LoginFailure('An unexpected error occurred.');
    }
  }
}
