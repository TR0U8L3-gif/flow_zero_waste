import 'dart:convert';
import 'dart:math';

import 'package:flow_zero_waste/core/common/data/dev/auth_data_base.dart';
import 'package:flow_zero_waste/src/auth/presentation/logics/auth_provider.dart';
import 'package:flow_zero_waste/src/profile/data/datasources/profile_data_source_exceptions.dart';
import 'package:flow_zero_waste/src/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:flow_zero_waste/src/profile/data/models/profile_stats_model.dart';
import 'package:injectable/injectable.dart';

/// Profile remote data source
@Singleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  /// Default constructor
  ProfileRemoteDataSourceImpl({
    required AuthProvider authProvider,
  }) : _authProvider = authProvider;

  final UserAuthHiveStorage _dbAuth =
      UserAuthHiveStorage(boxName: userBoxName);
  final CurrentUserAuthHiveStorage _dbUser =
      CurrentUserAuthHiveStorage(boxName: currentUserBoxName);
  final AuthProvider _authProvider;

  @override
  Future<ProfileStatsModel> getProfileStats() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final result = Random().nextInt(3);
    if (result == 0) {
      throw FailedToGetProfileStatsException(
        action: 'get profile stats',
        error: 'Failed to get profile stats timeout',
        stackTrace: StackTrace.current,
      );
    } else if (result == 1) {
      return const ProfileStatsModel(
        avoidedCO2eEmission: 25,
        orderCount: null,
        savedMoney: 200,
        plantedTrees: null,
        points: 1200,
      );
    } else {
      return const ProfileStatsModel(
        avoidedCO2eEmission: 25,
        orderCount: 15,
        savedMoney: 200,
        plantedTrees: 3,
        points: 1200,
      );
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 3));

    if (_authProvider.user == null) {
      throw FailedToChangePasswordException(
        action: 'change password',
        error: 'User is not logged in',
        stackTrace: StackTrace.current,
      );
    }

    final allUsers = await _dbAuth.readAll();

    for (final user in allUsers) {
      final userDecoded = json.decode(user) as Map<String, dynamic>;
      final checkPassword = userDecoded['password'] == currentPassword;
      final checkId = userDecoded['id'] == _authProvider.user!.id;
      final id = userDecoded['id'] as String;

      if (checkPassword && checkId) {
        final data = userDecoded..['password'] = newPassword;
        final jsonData = json.encode(data);
        await _dbAuth.write(jsonData, key: '$userKey$id');
        return;
      }
    }

    throw FailedToChangePasswordException(
      error: 'no user found',
      action: 'change password',
      stackTrace: StackTrace.current,
    );
  }

  @override
  Future<void> updateProfileData({
    required String? name,
    required String? email,
    required String? phoneNumber,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 3));

    if (_authProvider.user == null) {
      throw FailedToUpdateProfileDataException(
        error: 'User is not logged in',
        action: 'update profile data',
        stackTrace: StackTrace.current,
      );
    }
    final allUsers = await _dbAuth.readAll();

    for (final user in allUsers) {
      final userDecoded = json.decode(user) as Map<String, dynamic>;
      final checkId = userDecoded['id'] == _authProvider.user!.id;
      final id = userDecoded['id'] as String;

      if (checkId) {
        var data = userDecoded;
        if (name != null) data = data..['name'] = name;
        if (email != null) data = data..['email'] = email;
        if (phoneNumber != null) data = data..['phoneNumber'] = phoneNumber;
        final jsonData = json.encode(data);
        await _dbAuth.write(jsonData, key: '$userKey$id');
        await _dbUser.write(jsonData, key: currentUserKey);
        await _authProvider.fetchUserData();
        return;
      }
    }

    throw FailedToUpdateProfileDataException(
      error: 'no user found',
      action: 'update profile data',
      stackTrace: StackTrace.current,
    );
  }
}
