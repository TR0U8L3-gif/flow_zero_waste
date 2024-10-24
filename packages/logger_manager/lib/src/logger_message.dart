import 'package:flutter/foundation.dart';

@immutable

/// LoggerMessage class
///
/// pass as message parameter to log method in logger
class LoggerMessage {
  /// LoggerMessage constructor
  const LoggerMessage({
    required this.message,
    this.problemId,
    this.additionalProperties,
  });

  /// message
  final String message;

  /// problemId
  final String? problemId;

  /// additional properties
  final Map<String, Object>? additionalProperties;

  @override
  String toString() {
    return [
      'Problem ', 
      if(problemId != null) '[$problemId]',
      ': $message',
      if (additionalProperties != null)
        additionalProperties!.entries
            .map((entry) => '[${entry.key}]: ${entry.value}')
            .join(', ')
      else
        '',
    ].join();
  }
}
