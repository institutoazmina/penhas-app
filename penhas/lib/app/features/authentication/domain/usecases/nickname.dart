import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';

import 'map_validator_failure.dart';

@immutable
class Nickname extends Equatable with MapValidatorFailure {
  final Either<Failure, String> value;

  String get rawValue => value.getOrElse(() => null);
  bool get isValid => value.isRight();

  factory Nickname(String input) {
    return Nickname._(_validate(input));
  }

  Nickname._(this.value);

  @override
  List<Object> get props => [value];

  static Either<Failure, String> _validate(String input) {
    if (input == null || input.isEmpty) {
      return left(NicknameInvalidFailure());
    }

    return right(input);
  }

  @override
  String get mapFailure => throw UnimplementedError();
}
