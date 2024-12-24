import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import 'map_validator_failure.dart';

@immutable
class Cpf extends Equatable with MapValidatorFailure {
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
    // Limpa o conteúdo para obter apenas o número
    var numeros = input.replaceAll(RegExp(r'[^\d]'), '');
    if (numeros.isEmpty || numeros.length != 11) {
      return left(CpfInvalidFailure());
    }

    // Testar se todos os dígitos do CPF são iguais
    if (RegExp(r'^(\d)\1*$').hasMatch(numeros)) {
      return left(CpfInvalidFailure());
    }

    // Dividir dígitos
    List<int> digitos =
        numeros.split('').map((String d) => int.parse(d)).toList();

    // Calcular o primeiro dígito verificador
    var calcDv1 = 0;
    for (var i in Iterable<int>.generate(9, (i) => 10 - i)) {
      calcDv1 += digitos[10 - i] * i;
    }
    calcDv1 %= 11;
    var dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

    // Testar o primeiro dígito verificado
    if (digitos[9] != dv1) return left(CpfInvalidFailure());

    // Calcular o segundo dígito verificador
    var calcDv2 = 0;
    for (var i in Iterable<int>.generate(10, (i) => 11 - i)) {
      calcDv2 += digitos[11 - i] * i;
    }
    calcDv2 %= 11;
    var dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

    // Testar o segundo dígito verificador
    if (digitos[10] != dv2) return left(CpfInvalidFailure());

    // final cleared = input.replaceAll('.', '').replaceAll('-', '');

    return right(numeros);
  }

  @override
  String get mapFailure => value.fold(
        (failure) => 'CPF inválido',
        (r) => '',
      );
}
