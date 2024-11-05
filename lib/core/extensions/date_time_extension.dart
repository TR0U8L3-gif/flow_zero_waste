import 'package:intl/intl.dart';

/// DateTimeExtension extension
extension DateTimeExtension on DateTime {
  /// Get date and time
  /// in format yyyy-MM-dd HH:mm:ss
  String get dateAndTime {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }
}
