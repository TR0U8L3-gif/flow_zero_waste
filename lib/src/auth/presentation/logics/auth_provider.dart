import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/src/auth/domain/entities/user.dart';
import 'package:flow_zero_waste/src/auth/domain/usecases/get_current_user.dart';
import 'package:flow_zero_waste/src/auth/domain/usecases/login_user.dart';
import 'package:flow_zero_waste/src/auth/domain/usecases/logout_user.dart';
import 'package:flow_zero_waste/src/auth/domain/usecases/register_user.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// Auth provider
@singleton
class AuthProvider extends ChangeNotifier {
  /// Auth provider constructor
  AuthProvider({
    required GetCurrentUser getCurrentUser,
    required LoginUser loginUser,
    required LogoutUser logoutUser,
    required RegisterUser registerUser,
  })  : _getCurrentUser = getCurrentUser,
        _loginUser = loginUser,
        _logoutUser = logoutUser,
        _registerUser = registerUser;

  final GetCurrentUser _getCurrentUser;
  final LoginUser _loginUser;
  final LogoutUser _logoutUser;
  final RegisterUser _registerUser;

  User? _user;

  /// User getter
  User? get user => _user;

  /// Is logged in getter
  bool get isLoggedIn => _user != null;

  /// Fetch user data
  Future<void> fetchUserData() async {
    final result = await _getCurrentUser(const NoParams());

    result.fold(
      (failure) => null,
      (user) {
        _user = user;
      },
    );

    notifyListeners();
  }

  /// Login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final result = await _loginUser(
      LoginUserParams(
        email: email,
        password: password,
      ),
    );

    result.fold(
      (failure) => null,
      (user) {
        _user = user;
      },
    );
    
    notifyListeners();
  }

  /// Register
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    await _registerUser(
      RegisterUserParams(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      ),
    );
  }

  /// Logout
  Future<void> logout() async {
    await _logoutUser(const NoParams());
    _user = null;
    notifyListeners();
  }
}
