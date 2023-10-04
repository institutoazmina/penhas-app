import 'package:json_annotation/json_annotation.dart';

import 'date_time.dart';

abstract class FromJson {
  static String parseAsString(dynamic obj) => '$obj';

  static Iterable<String> parseAsStringList(Iterable<dynamic> obj) =>
      obj.map<String>(parseAsString);
}

class JsonSecondsFromEpochConverter implements JsonConverter<DateTime, int> {
  const JsonSecondsFromEpochConverter();

  @override
  DateTime fromJson(int json) => DateTimeExt.fromSecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.secondsSinceEpoch;
}

class JsonBoolConverter implements JsonConverter<bool, dynamic> {
  const JsonBoolConverter();

  @override
  bool fromJson(dynamic json) => json is bool ? json : '${json ?? 0}' == '1';

  @override
  dynamic toJson(bool object) => object == false ? null : object;
}

class JsonEmptyStringToNullConverter
    implements JsonConverter<String?, String?> {
  const JsonEmptyStringToNullConverter();

  @override
  String? fromJson(String? json) => json?.isEmpty == true ? null : json;

  @override
  String? toJson(String? object) => object?.isEmpty == true ? null : object;
}
