import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:logger_manager/logger_manager.dart';

/// Abstract class for repository
abstract class Repository {

  /// Logger instance
  final logger = locator<LoggerManager>();
}
