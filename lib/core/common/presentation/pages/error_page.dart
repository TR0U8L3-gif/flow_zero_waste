import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:logger_manager/logger_manager.dart';

/// ErrorPage is a StatelessWidget that displays an error page.
class ErrorPage extends StatefulWidget {
  /// Constructor for ErrorPage
  const ErrorPage({required this.data, this.reportError = false, super.key});

  /// ErrorPageData instance
  final ErrorPageData data;

  /// if true, report the error
  final bool reportError;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {

  @override
  void initState() {
    super.initState();
    if (widget.reportError) {
      locator<LoggerManager>().error(
        message: widget.data.message,
        error: widget.data.exception,
        stackTrace: widget.data.stackTrace,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data.title,
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (widget.data.exception != null)
              Text(
                widget.data.exception.runtimeType.toString(),
                style: context.textTheme.titleMedium,
              ),
            Text(
              widget.data.message,
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// ErrorPageData class to hold data for the error page
class ErrorPageData {
  /// Constructor for ErrorPageData
  const ErrorPageData({
    required this.title,
    required this.message,
    this.exception,
    this.stackTrace,
  });

  /// Title for the error page
  final String title;

  /// Message for the error page
  final String message;

  /// Exception for the error page
  final Exception? exception;

  /// StackTrace for the error page
  final StackTrace? stackTrace;
}
