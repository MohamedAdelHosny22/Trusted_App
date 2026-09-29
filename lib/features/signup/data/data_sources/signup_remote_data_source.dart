import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import '../models/signup_request.dart';
import '../models/signup_response.dart';
import '../repositories/signup_repository.dart';

abstract class SignupRemoteDataSource {
  Future<SignupResponse> signup(SignupRequest request);
}

class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  final Dio _dio;
  final String baseUrl;

  SignupRemoteDataSourceImpl({
    Dio? dio,
  })  : _dio = _buildDio(dio),
        baseUrl = 'http://trust.runasp.net/api';

  static Dio _buildDio(Dio? existing) {
    final dio = existing ?? Dio();
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        logPrint: (obj) => dev.log(obj.toString(), name: 'SIGNUP_DIO'),
      ),
    );
    return dio;
  }

  @override
  Future<SignupResponse> signup(SignupRequest request) async {
    dev.log('📤 Sending signup request...', name: 'SIGNUP');
    dev.log('📦 Body: ${request.toJson()}', name: 'SIGNUP');

    try {
      final response = await _dio.post(
        '$baseUrl/Auth/register',
        data: request.toJson(),
      );

      dev.log('✅ Response status: ${response.statusCode}', name: 'SIGNUP');
      dev.log('📥 Response body: ${response.data}', name: 'SIGNUP');

      final signupResponse = SignupResponse.fromJson(response.data);
      if (!signupResponse.isSuccess) {
        dev.log('❌ isSuccess=false → ${signupResponse.enRes}', name: 'SIGNUP');
        throw SignupFailure(signupResponse.enRes ?? 'Registration failed');
      }
      return signupResponse;

    } on DioException catch (e) {
      dev.log('🚨 DioException: type=${e.type}, status=${e.response?.statusCode}', name: 'SIGNUP');
      dev.log('🚨 Response body: ${e.response?.data}', name: 'SIGNUP');
      dev.log('🚨 Message: ${e.message}', name: 'SIGNUP');

      if (e.response != null && e.response?.statusCode == 400) {
        final data = e.response?.data;
        dev.log('⚠️ 400 data: $data', name: 'SIGNUP');

        if (data is Map<String, dynamic> && data['errors'] != null) {
          final errors = data['errors'] as Map<String, dynamic>;
          final firstErrorList = errors.values.first;
          if (firstErrorList is List && firstErrorList.isNotEmpty) {
            throw SignupFailure(firstErrorList.first.toString());
          }
        }
        // Might also have enRes directly
        if (data is Map<String, dynamic> && data['enRes'] != null) {
          throw SignupFailure(data['enRes'].toString());
        }
        throw const SignupFailure('Invalid input data provided.');
      } else if (e.response?.statusCode == 409) {
        throw const SignupFailure('User already exists.');
      } else if (e.response?.statusCode == 500) {
        throw const SignupFailure('Server error. Please try again later.');
      } else if (e.type == DioExceptionType.connectionError ||
                 e.type == DioExceptionType.unknown) {
        dev.log('🚨 Connection/CORS error: ${e.error}', name: 'SIGNUP');
        throw const SignupFailure('Connection error. Please check your internet connection.');
      } else {
        throw const SignupFailure('Connection error. Please check your internet connection.');
      }
    } catch (e) {
      dev.log('💥 Unexpected error: $e', name: 'SIGNUP');
      if (e is SignupFailure) rethrow;
      throw const SignupFailure('An unexpected error occurred.');
    }
  }
}
