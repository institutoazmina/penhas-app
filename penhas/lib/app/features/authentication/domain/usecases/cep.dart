import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';

import 'map_validator_failure.dart';

@immutable
class Cep extends Equatable with MapValidatorFailure {
  final Either<Failure, String> value;

  String get rawValue => value.getOrElse(() => null);
  bool get isValid => value.isRight();

  factory Cep(String input) {
    return Cep._(_validate(input));
  }

  Cep._(this.value);

  @override
  List<Object> get props => [value];

  @override
  bool get stringify => true;

  static Either<Failure, String> _validate(String input) {
    if (input == null || input.isEmpty) {
      return left(CepInvalidFailure());
    }

    var numbers = input.replaceAll(RegExp(r'\D'), '');

    if (numbers.length < 8) {
      return left(CepInvalidFailure());
    }

    return right(numbers);
  }

  @override
  String get mapFailure => value.fold(
        (failure) => 'CEP inválido',
        (r) => '',
      );
}
