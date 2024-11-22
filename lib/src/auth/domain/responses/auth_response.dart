import 'package:flow_zero_waste/core/common/domain/response.dart';

/// Auth failure
sealed class AuthFailure extends Failure{
  /// Default constructor
  const AuthFailure();
}

/// Invalid credentials auth failure
class InvalidCredentialsAuthFailure extends AuthFailure {
  /// Default constructor
  const InvalidCredentialsAuthFailure();
}

/// User already exist auth failure
class UserAlreadyExistAuthFailure extends AuthFailure {
  /// Default constructor
  const UserAlreadyExistAuthFailure();
}

/// Unable to logout current user auth failure
class LogoutFailedAuthFailure extends AuthFailure {
  /// Default constructor
  const LogoutFailedAuthFailure();
}

/// Current user not found auth failure
class CurrentUserNotFoundAuthFailure extends AuthFailure {
  /// Default constructor
  const CurrentUserNotFoundAuthFailure();
}

/// Unexpected auth failure
class UnexpectedAuthFailure extends AuthFailure {
  /// Default constructor
  const UnexpectedAuthFailure();
}
