import 'package:dio/dio.dart';
import 'package:flow_zero_waste/core/constants/secure_storage_constatnts.dart';
import 'package:flow_zero_waste/core/services/secure_storage/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Interceptor that adds the access token to the request headers
class AuthInterceptor extends Interceptor {
  /// Default constructor for [AuthInterceptor].
  AuthInterceptor(this._dio);

  final Dio _dio;
  final FlutterSecureStorage _storage = SecureStorageManager.storage;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Pobierz access token z bezpiecznego magazynu
    final accessToken = await _storage.read(key: accessTokenKey);
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options); // Przejdź do żądania
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Jeśli napotkamy 401, spróbuj odświeżyć token
    if (err.response?.statusCode == 401) {
      try {
        await _refreshToken();

        // Po odświeżeniu tokenu ponów oryginalne żądanie
        final retryOptions = err.requestOptions;
        final newAccessToken = await _storage.read(key: accessTokenKey);
        if (newAccessToken != null) {
          retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        }
        final response = await _dio.request<dynamic>(
          retryOptions.path,
          options: Options(
            method: retryOptions.method,
            headers: retryOptions.headers,
          ),
          data: retryOptions.data,
          queryParameters: retryOptions.queryParameters,
        );
        return handler.resolve(response); // Zwróć odpowiedź
      } catch (e) {
        // Jeśli odświeżenie się nie powiodło, przekieruj do logowania
        return handler.reject(err);
      }
    }
    return handler.next(err); // Jeśli to inny błąd, przekaż dalej
  }

  Future<void> _refreshToken() async {
    final refreshToken = await _storage.read(key: refreshTokenKey);
    if (refreshToken == null) throw Exception('No refresh token found');

    final response = await _dio.post<Map<String, dynamic>>('/auth/refresh',
        data: {'refreshToken': refreshToken});

    if (response.statusCode == 200) {
      final newAccessToken = response.data!['accessToken'] as String;
      final newRefreshToken = response.data!['refreshToken'] as String;
      await _storage.write(key: accessTokenKey, value: newAccessToken);
      await _storage.write(key: refreshTokenKey, value: newRefreshToken);
    } else {
      throw Exception('Failed to refresh token');
    }
  }
}
