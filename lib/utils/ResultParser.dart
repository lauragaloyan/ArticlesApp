import 'dart:convert';

import 'package:flutter/services.dart';

class ResultParser {
  static Future<Map<String, dynamic>> fetchJson(String path) async {
    String jsonString = await rootBundle.loadString(path);
    return jsonDecode(jsonString);
  }
}
