enum ApiContentType {
  json,
  formUrlEncoded,
}

extension ApiContentTypeExtension on ApiContentType {
  String get value {
    return this == ApiContentType.json
        ? 'application/json; charset=utf-8'
        : 'application/x-www-form-urlencoded; charset=utf-8';
  }
}
