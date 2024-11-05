import 'package:logger/logger.dart';

/// Function to stringify log event
String stringifyLogEvent(LogEvent event) => [
      'level: ${event.level}',
      'message: ${event.message}',
      if (event.error != null) 'error: ${event.error}',
      if (event.stackTrace != null) 'stackTrace: ${event.stackTrace}',
      'time: ${event.time}',
    ].join(', ');
