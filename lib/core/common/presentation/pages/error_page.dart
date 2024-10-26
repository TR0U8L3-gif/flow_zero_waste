import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// ErrorPage is a StatelessWidget that displays an error page.
class ErrorPage extends StatelessWidget {
  /// Constructor for ErrorPage
  const ErrorPage({required this.data, super.key});

  /// ErrorPageData instance
  final ErrorPageData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.title,
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (data.exception != null)
              Text(
                data.exception.runtimeType.toString(),
                style: context.textTheme.titleMedium,
              ),
            Text(
              data.message,
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
  });

  /// Title for the error page
  final String title;

  /// Message for the error page
  final String message;

  /// Exception for the error page
  final Exception? exception;
}
