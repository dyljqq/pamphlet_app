import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

class FileManager {
  static Future<dynamic> loadDataFromFile(String filename) async {
    try {
      final contents = await rootBundle.loadString(filename);
      return json.decode(contents);
    } catch (e) {
      return {};
    }
  }
}
