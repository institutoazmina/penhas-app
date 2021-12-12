extension SafetlyParser on Object? {
  double? safeParseDouble() {
    final value = this;

    if (value is String) {
      return double.tryParse(value);
    } else if (value is num) {
      return value.toDouble();
    }

    return null;
  }

  int? safeParseInt() {
    final value = this;

    if (value is String) {
      return int.tryParse(value) ?? def;
    } else if (value is num) {
      return value.toInt();
    }

    return def;
  }

  bool safeParseBool() {
    final value = this;
    try {
      return value == 1;
    } catch (e) {
      return false;
    }
  }
}
