import 'dart:ui' show Color;
import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:logger/logger.dart';
import 'package:logger_manager/core/helpers/fixed_sized_heap.dart';
import 'package:logger_manager/src/logger_output_service.dart';

/// ConsoleOutputService class
class TerminalOutputService extends LoggerOutputService with ChangeNotifier {
  /// Constructor for ConsoleOutputService
  TerminalOutputService({
    required super.canLog,
    required super.buildType,
    required super.logLevel,
    this.maxLogsLength = 24,
  }) {
    _heap = FixedSizeHeap<TerminalText>(maxSize: maxLogsLength);
  }

  /// Max logs length
  final int maxLogsLength;

  late final FixedSizeHeap<TerminalText> _heap;

  /// Get level color
  Color getLevelColor(Level level) {
    switch (level) {
      case Level.trace:
        return const Color(0xFF9E9E9E);
      case Level.debug:
        return const Color(0xFFFFC107);
      case Level.info:
        return const Color(0xFF2196F3);
      case Level.warning:
        return const Color(0xFFFF9800);
      case Level.error:
        return const Color(0xFFF44336);
      case Level.fatal:
        return const Color(0xFF9C27B0);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  @override
  void log(OutputEvent event) {
    // check if can log
    if (!canLog) return;

    // check if log level high enough
    if (event.level.index < logLevel.index) return;

    // add log to heap
    _heap.push(
      TerminalText(
        lines: _formatLines(event.lines),
        color: getLevelColor(event.level),
      ),
    );

    notifyListeners();
  }

  /// Format lines to match the terminal style
  List<String> _formatLines(List<String> lines) {
    const topLeftCorner = '┌';
    const bottomLeftCorner = '└';
    const middleCorner = '├';
    const verticalLine = '│';
    final formattedLines = <String>[];
    for (var i = 0; i < lines.length; i++) {
      if (i == 0) {
        formattedLines.add(_formatLine(lines[i], topLeftCorner));
      } else if (i == lines.length - 1) {
        formattedLines.add(_formatLine(lines[i], bottomLeftCorner));
      } else {
        formattedLines.add(
          _formatLine(_formatLine(lines[i], verticalLine), middleCorner),
        );
      }
    }
    return formattedLines;
  }

  /// format line to match the terminal style
  String _formatLine(String line, String prefix) {
    const weird = '[0m';
    final index = line.indexOf(prefix);
    if (index != -1) {
      return line.substring(index).replaceAll(weird, '');
    } else {
      return line.replaceAll(weird, '');
    }
  }

  /// Get logs as List of TextSpan
  List<({List<String> lines, Color color})> get logs {
    return _heap.heap.map((e) {
      return (lines: e.lines, color: e.color);
    }).toList();
  }
}

/// Class that output logs
class TerminalText {
  /// Constructor for TerminalText
  TerminalText({
    required this.lines,
    required this.color,
  });

  /// Text to be displayed
  final List<String> lines;

  /// Color of the text represented by level
  final Color color;
}
