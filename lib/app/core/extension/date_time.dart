extension DateTimeExt on DateTime {
  int get secondsSinceEpoch =>
      millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;

  static const months = {
    'Jan': DateTime.january,
    'Feb': DateTime.february,
    'Mar': DateTime.march,
    'Apr': DateTime.april,
    'May': DateTime.may,
    'Jun': DateTime.june,
    'Jul': DateTime.july,
    'Aug': DateTime.august,
    'Sep': DateTime.september,
    'Oct': DateTime.october,
    'Nov': DateTime.november,
    'Dec': DateTime.december,
  };

  /// Converts seconds since epoch to a [DateTime] object.
  static DateTime fromSecondsSinceEpoch(
    int secondsSinceEpoch, {
    bool isUtc = false,
  }) =>
      DateTime.fromMillisecondsSinceEpoch(
        secondsSinceEpoch * Duration.millisecondsPerSecond,
        isUtc: isUtc,
      );

  /// Converts a date in the format `Wed, 20 Dec 2023 01:45:39 GMT` to a
  /// [DateTime] object.
  static DateTime fromHttpFormat(String date) {
    final parts = date.split(' ');
    final day = int.parse(parts[1]);
    final month = DateTimeExt.months[parts[2]]!;
    final year = int.parse(parts[3]);
    final time = parts[4].split(':');
    final hour = int.parse(time[0]);
    final minute = int.parse(time[1]);
    final second = int.parse(time[2]);

    return DateTime.utc(year, month, day, hour, minute, second);
  }

  operator <(DateTime other) => isBefore(other);

  operator >(DateTime other) => isAfter(other);
}
