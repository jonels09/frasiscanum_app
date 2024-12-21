import 'package:flutter/services.dart';

class FileUtils {
  static Future<String> loadAsset(String path) async {
    try {
      return await rootBundle.loadString(path);
    } catch (e) {
      throw FileUtilsException('Failed to load asset: $path');
    }
  }
}

class FileUtilsException implements Exception {
  final String message;
  FileUtilsException(this.message);

  @override
  String toString() => message;
}
