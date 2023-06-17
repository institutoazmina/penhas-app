class Durations {
  static const long = 500;
  static const medium = 300;
  static const short = 150;
  static const extraShort = 80;
}

class LongDuration extends Duration {
  const LongDuration() : super(milliseconds: Durations.long);
}
