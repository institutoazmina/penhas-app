import 'dart:convert';
import 'dart:io';

class JsonUtil {
  static Future<Map<String, dynamic>> getJson({String from}) {
    return File("test/assets/json/$from")
        .readAsString()
        .then((fileContent) => JsonDecoder().convert(fileContent));
  }
}
