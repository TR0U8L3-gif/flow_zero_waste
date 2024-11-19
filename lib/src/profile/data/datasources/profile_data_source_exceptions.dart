import 'package:flow_zero_waste/core/common/data/exceptions.dart';

/// Failed to get profile stats exception
class FailedToGetProfileStatsException extends BaseException {
  /// Default constructor
  const FailedToGetProfileStatsException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}
