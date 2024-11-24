import 'dart:convert';

import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/core/common/data/dev/auth_data_base.dart';
import 'package:flow_zero_waste/src/auth/data/datasources/auth_data_source_exceptions.dart';
import 'package:flow_zero_waste/src/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flow_zero_waste/src/auth/data/models/auth_model.dart';
import 'package:flow_zero_waste/src/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';



/// Dev implementation of AuthRemoteDataSource that returns sample data.
@Singleton(as: AuthRemoteDataSource, env: [Env.development])
class AuthRemoteDataSourceImplDev implements AuthRemoteDataSource {
  final UserAuthHiveStorage _dbAuth =
      UserAuthHiveStorage(boxName: userBoxName);
  final CurrentUserAuthHiveStorage _dbUser =
      CurrentUserAuthHiveStorage(boxName: currentUserBoxName);
  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    final allUsers = await _dbAuth.readAll();

    for (final user in allUsers) {
      final userDecoded = json.decode(user) as Map<String, dynamic>;
      UserModel? userModel;
      try {
        userModel = UserModel.fromJson(userDecoded);
      } catch (e) {
        userModel = null;
        continue;
      }
      final checkEmail = userModel.email == email;
      final checkPassword = userDecoded['password'] == password;
      if (checkEmail && checkPassword) {
        await _dbUser.write(user, key: currentUserKey);
        return AuthModel(
          user: userModel,
          accessToken: 'sample_access_token_123',
          refreshToken: 'sample_refresh_token_456',
        );
      }
    }

    throw InvalidCredentialsException(
      error: 'Invalid credentials',
      action: 'login',
      stackTrace: StackTrace.current,
    );
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    final id = const Uuid().v4();
    final userRegistered = {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
    final jsonData = json.encode(userRegistered);
    final allUsers = await _dbAuth.readAll();
    for (final user in allUsers) {
      final userDecoded = json.decode(user) as Map<String, dynamic>;
      if (userDecoded['email'] == email) {
        throw UserAlreadyExistException(
          error: 'Email already in use',
          action: 'register',
          stackTrace: StackTrace.current,
        );
      }
    }
    await _dbAuth.write(jsonData, key: '$userKey$id');
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final jsonData = await _dbUser.read(key: currentUserKey);
      final userData = json.decode(jsonData!) as Map<String, dynamic>;
      final userModel = UserModel.fromJson(userData);
      return userModel;
    } catch (e, st) {
      throw CurrentUserNotFoundException(
        error: e,
        action: 'getCurrentUser',
        stackTrace: st,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
    await _dbUser.delete(key: currentUserKey);
    } catch (e, st) {
      throw LogoutFailedException(
        error: e,
        action: 'logout',
        stackTrace: st,
      );
    }
  }
}
