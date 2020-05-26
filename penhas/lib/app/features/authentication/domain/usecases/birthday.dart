import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';

@immutable
class Birthday extends Equatable {
  final Either<Failure, String> value;

  String get rawValue => value.getOrElse(() => null);
  bool get isValid => value.isRight();

  factory Birthday(String input) {
    return Birthday._(_validate(input));
  }

  factory Birthday.datetime(DateTime dt) {
    String input;
    if (dt != null) {
      final day = _twoDigits(dt.day);
      final month = _twoDigits(dt.month);
      final year = _fourDigits(dt.year);
      input = "$year-$month-$day";
    }

    return Birthday._(_validate(input));
  }

  Birthday._(this.value);

  @override
  List<Object> get props => [value];

  static Either<Failure, String> _validate(String input) {
    if (input == null || input.isEmpty) {
      return left(BirthdayInvalidFailure());
    }

    return right(input);
  }

  static String _fourDigits(int n) {
    int absN = n.abs();
    String sign = n < 0 ? "-" : "";
    if (absN >= 1000) return "$n";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  static String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}
