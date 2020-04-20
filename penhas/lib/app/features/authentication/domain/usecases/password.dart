import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';

@immutable
class Password extends Equatable {
  final Either<Failure, String> value;

  String get rawValue => value.getOrElse(() => null);

  factory Password(String input) {
    return Password._(_validate(input));
  }

  const Password._(this.value);

  @override
  List<Object> get props => [value];

  static Either<Failure, String> _validate(String input) {
    if (input == null || input.isEmpty) {
      return left(PasswordInvalidFailure());
    }

    return right(input);
  }
}
