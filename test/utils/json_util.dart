import 'dart:convert';
import 'dart:io';

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
