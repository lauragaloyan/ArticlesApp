import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'AppExceptions.dart';

class ApiBaseHelper {
  final String _baseUrl = "https://jsonkeeper.com/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
    print("received!");
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
      case 500:
      default:
        throw FetchDataException(
            "Error with statusCode: ${response.statusCode}");
    }
  }
}