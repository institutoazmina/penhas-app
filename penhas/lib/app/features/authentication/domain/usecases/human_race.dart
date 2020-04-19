import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';

@immutable
class HumanRace extends Equatable {
  final Either<Failure, String> value;

  factory HumanRace(String input) {
    return HumanRace._(_validate(input));
  }

  const HumanRace._(this.value);

  @override
  List<Object> get props => [value];

  static Either<Failure, String> _validate(String input) {
    if (input == null || input.isEmpty) {
      return left(HumanRaceInvalidFailure());
    }

    return right(input);
  }
}
