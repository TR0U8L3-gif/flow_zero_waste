import 'package:flow_zero_waste/core/common/data/exceptions.dart';

/// Exception thrown when hive manager fails
class HiveManagerException extends BaseException {
  /// HiveManager exception constructor
  const HiveManagerException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}
