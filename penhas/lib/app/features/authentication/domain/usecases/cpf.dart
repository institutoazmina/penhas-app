import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/map_validator_failure.dart';

@immutable
class Cpf extends Equatable with MapValidatorFailure {
  final Either<Failure, String?> value;

  String? get rawValue => value.getOrElse(() => '');
  bool get isValid => value.isRight();

  factory Cpf(String input) {
    return Cpf._(_validate(input));
  }

  Cpf._(this.value);

  final Either<Failure, String?> value;

  String? get rawValue => value.getOrElse(() => '');
  bool get isValid => value.isRight();

  @override
  List<Object?> get props => [value];

  @override
  bool get stringify => true;

  static Either<Failure, String> _validate(String input) {
    if (!CPF.isValid(input)) {
      return left(CpfInvalidFailure());
    }

    final cleared = input.replaceAll('.', '').replaceAll('-', '');

    return right(cleared);
  }

  @override
  String get mapFailure => value.fold(
        (failure) => 'CPF inválido',
        (r) => '',
      );
}
