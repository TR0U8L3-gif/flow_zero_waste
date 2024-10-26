import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.data});
  final ErrorPageData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title, style: context.textTheme.headlineMedium,),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (data.exception != null)
              Text(data.exception.runtimeType.toString(), style: context.textTheme.titleMedium,),
            Text(data.message, style: context.textTheme.bodyMedium,),
          ],
        ),
      ),
    );
  }
}

class ErrorPageData {
  final String title;
  final String message;
  final Exception? exception;

  const ErrorPageData({
    required this.title,
    required this.message,
    this.exception,
  });
}
