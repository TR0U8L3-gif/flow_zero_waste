import 'package:flow_zero_waste/src/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flow_zero_waste/src/auth/data/models/auth_model.dart';
import 'package:flow_zero_waste/src/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

/// Dev implementation of AuthRemoteDataSource that returns sample data.
@Singleton(as: AuthRemoteDataSource, env: [Environment.dev])
class AuthRemoteDataSourceImplDev implements AuthRemoteDataSource {
  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    // Przykładowe wartości dla AuthModel przy logowaniu
    const user = UserModel(
      id: 'user123',
      name: 'Jan Kowalski',
      email: 'jan.kowalski@example.com',
      phoneNumber: '123456789',
    );
    return const AuthModel(
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
    // Przykładowa implementacja dla rejestracji (niezwracająca żadnej wartości)
    print('User registered with name: $name, email: $email, phone: $phoneNumber');
  }

  @override
  Future<UserModel> getCurrentUser() async {
    // Przykładowe wartości dla UserModel przy pobieraniu bieżącego użytkownika
    return const UserModel(
      id: 'user123',
      name: 'Jan Kowalski',
      email: 'jan.kowalski@example.com',
      phoneNumber: '123456789',
    );
  }
}
