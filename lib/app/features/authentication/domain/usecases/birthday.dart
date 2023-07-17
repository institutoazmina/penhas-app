import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../shared/logger/log.dart';
import 'map_validator_failure.dart';

@immutable
class Birthday extends Equatable with MapValidatorFailure {
  factory Birthday(String? input) {
    return Birthday._(_validate(input));
  }

  factory Birthday.datetime(DateTime dt) {
    String? input;
    final day = _twoDigits(dt.day);
    final month = _twoDigits(dt.month);
    final year = _fourDigits(dt.year);
    input = '$day/$month/$year';

    return Birthday._(_validate(input));
  }

  Birthday._(this.value);

  final Either<Failure, String?> value;

  String? get rawValue => value.getOrElse(() => null);
  bool get isValid => value.isRight();

  @override
  List<Object?> get props => [value];

  @override
  bool get stringify => true;

  static Either<Failure, String?> _validate(String? input) {
    if (input == null || input.isEmpty) {
      return left(BirthdayInvalidFailure());
    }

    final dates = input.split('/');
    bool isValid = false;
    String? formatedDate;

    if (dates.length == 3) {
      final year = _parseIntSafety(dates[2]);
      final month = _parseIntSafety(dates[1]);
      final day = _parseIntSafety(dates[0]);

      final dt = DateTime.utc(year, month, day);

      final d = _twoDigits(dt.day);
      final m = _twoDigits(dt.month);
      final y = _fourDigits(dt.year);

      formatedDate = '$y-$m-$d';
      isValid = dt.day == day &&
          dt.month == month &&
          dt.year == year &&
          dates[2].length == 4;
    }

    if (isValid) {
      return right(formatedDate);
    } else {
      return left(BirthdayInvalidFailure());
    }
  }

  static String _fourDigits(int n) {
    final int absN = n.abs();
    final String sign = n < 0 ? '-' : '';
    if (absN >= 1000) return '$n';
    if (absN >= 100) return '${sign}0$absN';
    if (absN >= 10) return '${sign}00$absN';
    return '${sign}000$absN';
  }

  static String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  static int _parseIntSafety(String value) {
    try {
      return int.parse(value);
    } catch (e, stack) {
      logError(e, stack);
      return 99;
    }
  }

  @override
  String get mapFailure => value.fold(
        (failure) => 'Data de nascimento inválida',
        (r) => '',
      );
}
