import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';

@immutable
class Cpf extends Equatable {
  final Either<Failure, String> value;

  factory Cpf(String input) {
    return Cpf._(_validate(input));
  }

  const Cpf._(this.value);

  @override
  List<Object> get props => [value];

  static Either<Failure, String> _validate(String input) {
    if (input == null || input.isEmpty) {
      return left(CpfInvalidFailure());
    }

    return right(input);
  }
}
