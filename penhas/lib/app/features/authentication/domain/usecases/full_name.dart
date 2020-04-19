import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';

@immutable
class Fullname extends Equatable {
  final Either<Failure, String> value;

  factory Fullname(String input) {
    return Fullname._(_validate(input));
  }

  const Fullname._(this.value);

  @override
  List<Object> get props => [value];

  static Either<Failure, String> _validate(String input) {
    if (input == null || input.isEmpty) {
      return left(FullnameInvalidFailure());
    }

    return right(input);
  }
}
