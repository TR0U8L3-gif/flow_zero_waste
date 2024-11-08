import 'package:flow_zero_waste/src/auth/data/models/auth_model.dart';

/// Auth local data source
abstract class AuthLocalDataSource {
  /// Logout
  Future<void> logout();
  /// Save auth
  Future<void> saveAuth(AuthModel auth);
  /// Get auth
  Future<AuthModel?> getAuth();
}
