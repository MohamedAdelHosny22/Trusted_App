import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/user_model.dart';
import '../repositories/login_repository.dart';
import '../../../../core/models/user_role.dart';

/// Pre-defined mediator accounts
///
/// These are the ONLY accounts that can login as mediators
/// Regular users cannot sign up as mediators
class _MediatorAccount {
  final String email;
  final String password;
  final String id;
  final String username;
  final String displayName;

  const _MediatorAccount({
    required this.email,
    required this.password,
    required this.id,
    required this.username,
    required this.displayName,
  });
}

/// List of pre-defined mediator accounts
const List<_MediatorAccount> _predefinedMediators = [
  _MediatorAccount(
    email: 'mm@test.com',
    password: 'mm1234',
    id: 'mediator-mm-001',
    username: 'mm',
    displayName: 'Test Mediator',
  ),
  // Add more mediators here as needed
  // _MediatorAccount(
  //   email: 'ahmed@test.com',
  //   password: 'mediator123',
  //   id: 'mediator-ahmed-002',
  //   username: 'ahmed_mediator',
  //   displayName: 'Ahmed Mediator',
  // ),
];

/// LoginRemoteDataSource - Authentication data source interface
///
/// Abstract contract for remote authentication operations
/// Implementations can use HTTP, Firebase, or any other auth service
abstract class LoginRemoteDataSource {
  /// Authenticate user with credentials
  ///
  /// Throws [LoginFailure] if authentication fails
  Future<LoginResponse> login(LoginRequest request);
}

/// LoginRemoteDataSourceImpl - HTTP implementation
///
/// Mock implementation simulates API call with delay
/// In production, replace with actual HTTP client (dio, http, etc.)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  // Simulated network delay
  static const Duration _networkDelay = Duration(seconds: 2);

  const LoginRemoteDataSourceImpl();

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    // Simulate network delay
    await Future.delayed(_networkDelay);

    // Check if it's a mediator account
    final mediator = _predefinedMediators.firstWhere(
      (m) =>
          (m.email == request.username || m.username == request.username) &&
          m.password == request.password,
      orElse: () => _MediatorAccount(
        email: '',
        password: '',
        id: '',
        username: '',
        displayName: '',
      ),
    );

    // If mediator account found
    if (mediator.id.isNotEmpty) {
      return LoginResponse(
        user: UserModel(
          id: mediator.id,
          username: mediator.username,
          email: mediator.email,
          displayName: mediator.displayName,
          createdAt: DateTime.now(),
          role: UserRole.mediator,
        ),
        accessToken: 'mock-mediator-token-${mediator.id}',
        refreshToken: 'mock-mediator-refresh-token-${mediator.id}',
        expiresIn: 3600,
      );
    }

    // Regular user validation (mock)
    // In production, this would be an actual API call
    if (_isValidUserCredentials(request.username, request.password)) {
      return LoginResponse.mock();
    } else {
      throw const LoginFailure('Invalid username or password');
    }
  }

  /// Validate user credentials (mock implementation)
  ///
  /// In production, this is handled by the API
  bool _isValidUserCredentials(String username, String password) {
    // Mock validation: accept any valid format for regular users
    return username.length >= 3 && password.length >= 6;
  }
}

/// LoginRemoteDataSourceImpl - Production HTTP implementation example
///
/// This is commented out as an example for when you integrate a real API
/*
class LoginRemoteDataSourceImplHttp implements LoginRemoteDataSource {
  final Dio _dio;
  final String baseUrl;

  LoginRemoteDataSourceImplHttp({
    required String baseUrl,
    Dio? dio,
  })  : _dio = dio ?? Dio(),
        baseUrl = baseUrl;

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/login',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw LoginFailure('Authentication failed');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const LoginFailure('Invalid username or password');
      } else if (e.response?.statusCode == 500) {
        throw const LoginFailure('Server error. Please try again later.');
      } else {
        throw const LoginFailure('Network error. Please check your connection.');
      }
    } catch (e) {
      throw const LoginFailure('An unexpected error occurred');
    }
  }
}
*/
