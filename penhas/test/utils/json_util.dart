import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';

class JsonUtil {
  static Future<Map<String, dynamic>> getJson({@required String from}) {
    return JsonUtil.getString(from: from)
        .then((fileContent) => JsonDecoder().convert(fileContent));
  }

  static Future<String> getString({@required String from}) {
    return File("test/assets/json/$from").readAsString();
  }
}
