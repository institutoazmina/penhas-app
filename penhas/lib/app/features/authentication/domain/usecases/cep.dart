import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';

@immutable
class Cep extends Equatable {
  final Either<Failure, String> value;

  factory Cep(String input) {
    return Cep._(_validate(input));
  }

  const Cep._(this.value);

  @override
  List<Object> get props => [value];

  static Either<Failure, String> _validate(String input) {
    if (input == null || input.isEmpty) {
      return left(CepInvalidFailure());
    }

    return right(input);
  }
}
