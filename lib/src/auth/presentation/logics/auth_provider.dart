import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/src/auth/domain/entities/user.dart';
import 'package:flow_zero_waste/src/auth/domain/usecases/get_current_user.dart';
import 'package:flow_zero_waste/src/auth/domain/usecases/logout_user.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// Auth provider
@singleton
class AuthProvider extends ChangeNotifier {
  /// Auth provider constructor
  AuthProvider({
    required GetCurrentUser getCurrentUser,
    required LogoutUser logoutUser,
  })  : _getCurrentUser = getCurrentUser,
        _logoutUser = logoutUser;

  final GetCurrentUser _getCurrentUser;
  final LogoutUser _logoutUser;

  User? _user;

  /// User getter
  User? get user => _user;

  /// Is logged in getter
  bool get isLoggedIn => _user != null;

  /// Fetch user data
  Future<void> fetchUserData() async {
    final result = await _getCurrentUser(const NoParams());

    result.fold(
      (failure) {
        _user = null;
      },
      (user) {
        _user = user;
      },
    );

    notifyListeners();
  }

  /// Update user data
  void updateUserData(User user) {
    _user = user;
    notifyListeners();
  }

  /// Remove user data
  Future<void> removeUserData() async {
    await _logoutUser(const NoParams());
    _user = null;
    notifyListeners();
  }
}
