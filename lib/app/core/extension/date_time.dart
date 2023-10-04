extension DateTimeExt on DateTime {
  int get secondsSinceEpoch =>
      millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;

  static DateTime fromSecondsSinceEpoch(
    int secondsSinceEpoch, {
    bool isUtc = false,
  }) =>
      DateTime.fromMillisecondsSinceEpoch(
        secondsSinceEpoch * Duration.millisecondsPerSecond,
        isUtc: isUtc,
      );
}
