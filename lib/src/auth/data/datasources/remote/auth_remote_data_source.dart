import 'package:flow_zero_waste/src/auth/data/models/auth_model.dart';
import 'package:flow_zero_waste/src/auth/data/models/user_model.dart';
/// Auth remote data source abstract class.
abstract class AuthRemoteDataSource {
  /// Login
  Future<AuthModel> login({
    required String email,
    required String password,
  });

  /// Register
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  });

  /// Get current user
  Future<UserModel> getCurrentUser();
}
