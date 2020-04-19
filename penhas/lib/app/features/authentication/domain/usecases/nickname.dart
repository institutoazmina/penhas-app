import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';

@immutable
class Nickname extends Equatable {
  final Either<Failure, String> value;

  factory Nickname(String input) {
    return Nickname._(_validate(input));
  }

  const Nickname._(this.value);

  @override
  List<Object> get props => [value];

  static Either<Failure, String> _validate(String input) {
    if (input == null || input.isEmpty) {
      return left(NicknameInvalidFailure());
    }

    return right(input);
  }
}
