import 'package:dio/dio.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/core/common/data/response_model.dart';
import 'package:flow_zero_waste/core/services/dio/auth_interceptor.dart';
import 'package:flow_zero_waste/src/auth/data/datasources/auth_data_source_exceptions.dart';
import 'package:flow_zero_waste/src/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flow_zero_waste/src/auth/data/models/auth_model.dart';
import 'package:flow_zero_waste/src/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

/// Production implementation of AuthRemoteDataSource.
@Singleton(as: AuthRemoteDataSource, env: [Env.production])
class AuthRemoteDataSourceImplProd implements AuthRemoteDataSource {
  /// Default constructor.
  AuthRemoteDataSourceImplProd() : _dio = Dio() {
    _dio.interceptors.add(AuthInterceptor(_dio));
  }

  final Dio _dio;
  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        'https://flowauthapi.azurewebsites.net/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final data = ResponseModel<AuthModel>.fromJson(response.data!).result;

      if (data == null) {
        throw InvalidCredentialsException(
          error: 'Invalid credentials',
          action: 'login',
          stackTrace: StackTrace.current,
        );
      }

      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      await _dio.post<Map<String, dynamic>>(
        'https://flowauthapi.azurewebsites.net/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      // final response = await _dio.get('https://flowauthapi.azurewebsites.net/auth/me');

      return const UserModel(
        id: 'eb868909-e8e9-4c61-bd1e-2648e300d93c',
        name: 'Radosław',
        email: 'rsienkiewicz88@gmail.com',
        phoneNumber: '123456789',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    return;
  }
}
