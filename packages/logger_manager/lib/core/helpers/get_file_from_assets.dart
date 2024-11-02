import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// get file from assets
Future<File> getFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');
  final buffer = byteData.buffer;
  final tempDir = await getTemporaryDirectory();
  final tempPath = tempDir.path;
  final filePath =
      '$tempPath/file_cpy.tmp'; 
  return File(filePath).writeAsBytes(
    buffer.asUint8List(
      byteData.offsetInBytes,
      byteData.lengthInBytes,
    ),
  );
}
