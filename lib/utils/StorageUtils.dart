import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageUtils {
  static List<dynamic> _cachedData = List();

  static Future<File> get _cachedFilePath async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    return File(documentsDirectory.path + "/articles.json");
  }

  static Future<void> writeFile(dynamic jsonObject) async {
    _cachedData = jsonObject;

    String jsonBody = json.encode(jsonObject);
    File file = await _cachedFilePath;
    await file.writeAsString(jsonBody, flush: true);
  }

  static Future<dynamic> readFile() async {
    if (_cachedData != null) {
      return _cachedData;
    }

    File file = await _cachedFilePath;

    if (await file.exists()) {
      var jsonBody = await file.readAsString();
      return json.decode(jsonBody);
    } else {
      return null;
    }
  }
}