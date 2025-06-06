import 'package:flutter/foundation.dart';

/// Response class to parse API response to user friendly format
@immutable
abstract class Response {
  /// Constructor for Response
  const Response({this.message, this.data});

  /// Readable message for the response
  final String? message;

  /// Dynamic data for the response
  final Object? data;

  @override
  bool operator ==(Object other) {
    return other is Response && other.message == message && other.data == data;
  }

  @override
  int get hashCode {
    return Object.hashAll([message, data]);
  }
}

/// Success response
class Success extends Response {
  /// Constructor for Success
  const Success({super.message, super.data});
}

/// Failure response
class Failure extends Response {
  /// Constructor for Failure
  const Failure({super.message, super.data});
}
