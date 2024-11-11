import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/auth/domain/entities/user.dart';

/// Abstract Auth repository
abstract class AuthRepository {
  /// Login
  ResultFuture<Failure, User> login({
    required String email,
    required String password,
  });

  /// Register
  ResultFuture<Failure, void> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  });

  /// Get current user
  ResultFuture<Failure, User?> getCurrentUser();

  /// Logout
  ResultFuture<Failure, void> logout();

}
