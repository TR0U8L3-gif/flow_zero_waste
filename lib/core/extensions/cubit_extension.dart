import 'package:bloc/bloc.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:logger_manager/logger_manager.dart';

/// Cubit extension
extension CubitExtension on Cubit<dynamic> {
  /// Logger
  LoggerManager get logger => locator<LoggerManager>();
}
