extension SafetlyParser on Object {
  double safeParseDouble() {
    final value = this;

    if (value is String) {
      return double.tryParse(value);
    } else if (value is num) {
      return value.toDouble();
    }

    return null;
  }

  int safeParseInt() {
    final value = this;

    if (value is String) {
      return int.tryParse(value);
    } else if (value is num) {
      return value.toInt();
    }

    return null;
  }

  bool safeParseBool() {
    final value = this;
    try {
      return (value as num) == 1 ?? false;
    } catch (e) {
      return false;
    }
  }
}
