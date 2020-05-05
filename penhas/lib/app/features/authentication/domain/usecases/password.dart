import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';

@immutable
class Password extends Equatable {
  final Either<Failure, String> value;
  static const _minLength = 6;
  static const _maxLength = 200;

  String get rawValue => value.getOrElse(() => null);
  bool get isValid => value.isRight();

  factory Password(String input) {
    return Password._(_validate(input));
  }

  const Password._(this.value);

  @override
  List<Object> get props => [value];

  static Either<Failure, String> _validate(String input) {
    if (input == null ||
        input.isEmpty ||
        input.length < _minLength ||
        input.length > _maxLength) {
      return left(PasswordInvalidFailure());
    }

    return right(input);
  }
}
