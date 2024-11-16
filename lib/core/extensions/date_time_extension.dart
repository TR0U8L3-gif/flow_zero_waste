// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

/// DateTimeExtension extension
extension DateTimeExtension on DateTime {
  /// Get date and time
  /// in format yyyy-MM-dd HH:mm:ss
  String get dateAndTime {
    return DateFormat('yyyy.MM.dd HH:mm:ss').format(this);
  }

  /// Get date 
  /// in format yyyy-MM-dd
  String get ddMMyyyy {
    return DateFormat('dd.MM.yyyy').format(this);
  }

  /// Get time
  /// in format HH:mm
  String get HHmm {
    return DateFormat('HH:mm').format(this);
  }
}
