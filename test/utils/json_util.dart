import 'dart:convert';
import 'dart:io';

import 'package:penhas/app/core/types/json.dart';

class JsonUtil {
  static Future<Map<String, dynamic>> getJson({required String? from}) {
    return JsonUtil.getString(from: from).then(
      (fileContent) => jsonDecode(fileContent) as Map<String, dynamic>,
    );
  }

  static Future<String> getString({required String? from}) {
    return File('test/assets/json/$from').readAsString();
  }

  static String getStringSync({required String from}) =>
      File('test/assets/json/$from').readAsStringSync();
}

extension JsonObjectExtension on Object {
  /// Convert object to json object
  /// it is useful to compare json objects in tests
  /// jsonDecode and jsonEncode are used together to convert object to json object
  /// including their nested objects
  JsonObject get asJsonObject => jsonDecode(jsonEncode(this));
}
