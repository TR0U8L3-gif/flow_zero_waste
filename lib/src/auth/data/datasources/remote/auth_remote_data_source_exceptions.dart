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
