import 'package:flow_zero_waste/core/common/data/exceptions.dart';

/// Exception thrown when invalid credentials are provided
class InvalidCredentialsException extends BaseException {
  /// Default constructor
  const InvalidCredentialsException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}

/// Exception thrown when user already exists
class UserAlreadyExistException extends BaseException {
  /// Default constructor
  const UserAlreadyExistException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}

/// Exception thrown when current user is not found
class CurrentUserNotFoundException extends BaseException {
  /// Default constructor
  const CurrentUserNotFoundException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}

/// Exception thrown when logout failed
class LogoutFailedException extends BaseException {
  /// Default constructor
  const LogoutFailedException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}
