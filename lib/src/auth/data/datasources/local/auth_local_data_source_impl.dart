import 'dart:convert';

import 'package:flow_zero_waste/core/common/data/exceptions.dart';
import 'package:flow_zero_waste/core/constants/secure_storage_constants.dart';
import 'package:flow_zero_waste/core/services/secure_storage/secure_storage.dart';
import 'package:flow_zero_waste/src/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:flow_zero_waste/src/auth/data/models/auth_model.dart';
import 'package:flow_zero_waste/src/auth/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const _userKey = 'user_data';

/// Local implementation of AuthLocalDataSource.
@Singleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage = SecureStorageManager.storage;

  @override
  Future<AuthModel?> getAuth() async {
    final refreshToken = await _secureStorage.read(key: refreshTokenKey);
    final accessToken = await _secureStorage.read(key: accessTokenKey);
    final userData = await _secureStorage.read(key: _userKey);

    if (refreshToken == null || accessToken == null || userData == null) {
      return null;
    }

    try {
      final userJson = json.decode(userData) as Map<String, dynamic>;
      final user = UserModel.fromJson(userJson);
      return AuthModel(
        user: user,
        refreshToken: refreshToken,
        accessToken: accessToken,
      );
    } catch (e, st) {
      throw CacheException(
        error: e,
        action: 'get auth',
        stackTrace: st,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _secureStorage.delete(key: refreshTokenKey);
      await _secureStorage.delete(key: accessTokenKey);
      await _secureStorage.delete(key: _userKey);
    } catch (e, st) {
      throw CacheException(
        error: e,
        action: 'logout',
        stackTrace: st,
      );
    }
  }

  @override
  Future<void> saveAuth(AuthModel auth) async {
    String userData;
    try {
      userData = json.encode(auth.user.toJson());
    } catch (e) {
      throw CacheException(
        error: e,
        action: 'save auth',
        stackTrace: StackTrace.current,
      );
    }

    await _secureStorage.write(key: refreshTokenKey, value: auth.refreshToken);
    await _secureStorage.write(key: accessTokenKey, value: auth.accessToken);
    await _secureStorage.write(key: _userKey, value: userData);
  }
}
