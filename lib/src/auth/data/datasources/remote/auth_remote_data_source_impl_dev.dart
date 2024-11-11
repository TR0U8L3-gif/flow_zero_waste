import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/src/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flow_zero_waste/src/auth/data/datasources/remote/auth_remote_data_source_exceptions.dart';
import 'package:flow_zero_waste/src/auth/data/models/auth_model.dart';
import 'package:flow_zero_waste/src/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

/// Dev implementation of AuthRemoteDataSource that returns sample data.
@Singleton(as: AuthRemoteDataSource, env: [Env.development])
class AuthRemoteDataSourceImplDev implements AuthRemoteDataSource {
  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    await Future<dynamic>.delayed(const Duration(seconds: 2));

    if (email != 'rsienkiewicz88@gmail.com' || password != 'password') {
      throw InvalidCredentialsException(
        error: 'Invalid credentials',
        action: 'login',
        stackTrace: StackTrace.current,
      );
    }

    // Przykładowe wartości dla AuthModel przy logowaniu
    final user = UserModel(
      id: '3fc4eb93-6dc0-4b2a-99f3-835b41ffea73',
      name: 'Radosław Sienkiewicz',
      email: email,
      phoneNumber: '798465557',
    );
    return AuthModel(
      user: user,
      accessToken: 'sample_access_token_123',
      refreshToken: 'sample_refresh_token_456',
    );
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    await Future<dynamic>.delayed(const Duration(seconds: 4));
  }

  @override
  Future<UserModel> getCurrentUser() async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    return const UserModel(
      id: 'user123',
      name: 'Jan Kowalski',
      email: 'jan.kowalski@example.com',
      phoneNumber: '123456789',
    );
  }
}
